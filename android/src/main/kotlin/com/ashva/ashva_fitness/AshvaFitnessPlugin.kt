package com.ashva.ashva_fitness

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.fitness.Fitness
import com.google.android.gms.fitness.FitnessOptions
import com.google.android.gms.fitness.data.DataSet
import com.google.android.gms.fitness.data.DataSource
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar

import com.google.android.gms.fitness.data.DataType
import com.google.android.gms.fitness.data.Field
import com.google.android.gms.fitness.request.DataReadRequest
import com.google.android.gms.fitness.result.DataReadResponse
import com.google.android.gms.tasks.Tasks
import io.flutter.plugin.common.PluginRegistry
import java.text.DateFormat
import java.util.*
import java.util.concurrent.TimeUnit
import com.google.android.gms.fitness.result.DailyTotalResult
import com.google.android.gms.tasks.OnFailureListener
import com.google.android.gms.tasks.OnSuccessListener

import net.danlew.android.joda.JodaTimeAndroid

import org.joda.time.DateTime
import org.json.JSONObject

class AshvaFitnessPlugin(private val activity: Activity) : MethodCallHandler, PluginRegistry.ActivityResultListener {

    companion object {
        const val GOOGLE_FIT_PERMISSIONS_REQUEST_CODE = 1

        private val REQUEST_OAUTH_REQUEST_CODE = 0x1001
        // private val TAG = "MainActivity"

        internal var ESTIMATED_STEP_DELTAS = DataSource.Builder()
                .setDataType(DataType.TYPE_STEP_COUNT_DELTA)
                .setType(DataSource.TYPE_DERIVED)
                .setStreamName("estimated_steps")
                .setAppPackageName("com.google.android.gms")
                .build()


        val dataType: DataType = DataType.TYPE_STEP_COUNT_DELTA
        val aggregatedDataType: DataType = DataType.AGGREGATE_STEP_COUNT_DELTA

        val TAG = AshvaFitnessPlugin::class.java.simpleName

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            if (registrar.activity() == null) return;

            val plugin = AshvaFitnessPlugin(registrar.activity())
            registrar.addActivityResultListener(plugin)

            val channel = MethodChannel(registrar.messenger(), "flutter_health_fit")
            channel.setMethodCallHandler(plugin)
        }
    }


    private var deferredResult: Result? = null


    /*override fun onCreate(savedInstanceState: Bundle) {
        super.onCreate(savedInstanceState)
    }*/

    override fun onMethodCall(call: MethodCall, result: Result) {

        println("RESULT result -- " + result)
        println("RESULT call-- " + call)

        // Initialise JodaTime
        JodaTimeAndroid.init(activity)

        //counter = findViewById(R.id.counter);
        //weekCounter = findViewById(R.id.week_counter);

        //if (hasFitPermission()) {
        readStepCountDelta()
        //readHistoricStepCount()
        //} else {
        //requestFitnessPermission()
        //}

        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")

            "requestAuthorization" -> connect(result)

            //"getBasicHealthData" -> result.success(HashMap<String, String>())

            /*"getExactTodaysStepCount" -> {
                val count = readStepCountDelta()
                println("Todays getExactTodaysStepCount count "+count)
            }*/

            "getBasicHealthData" -> getMoveInMIn(result); //result.success(HashMap<String, String>())

            "getMoveInMinData" -> getMoveInMinData(result);

            "getCaloriesData" -> getCaloriesData(result);

            "getDistanceData" -> getDistanceData(result);

            "getHeartRateData" -> getHeartRateData(result);

            "getStepsHistoryData" -> {
                println("Mallikarjun calling this method")

                var startDate = call.argument<String>("startDate")
                var endDate = call.argument<String>("endDate")

                println("getStepsHistoryData startDate - " + startDate)
                println("getStepsHistoryData endDate - " + endDate)

                readHistoricStepCount(result)
            }

            "getActivity" -> {
                val name = call.argument<String>("name")

                println("Todays name - " + name)

                when (name) {
                    "steps" -> getYesterdaysStepsTotal(result)

                    else -> {
                        val map = HashMap<String, Double>()
                        map["value"] = 0.0
                        result.success(map)
                    }
                }
            }

            else -> result.notImplemented()
        }
    }


    /**
     * Reads the current daily step total, computed from AshvaID night of the current day on the device's
     * current timezone.
     */
    private fun readStepCountDelta() {
//        if (!hasFitPermission()) {
//            requestFitnessPermission()
//            return
//        }

        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_STEP_COUNT_DELTA)
                .addOnSuccessListener { dataSet ->
                    val total = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_STEPS).asInt()).toLong()

                    println("Todays count - " + String.format(Locale.ENGLISH, "%d", total))
                    //counter.setText(String.format(Locale.ENGLISH, "%d", total))
                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })
    }

    private fun readHistoricStepCount(result: Result) {
        /*if (!hasFitPermission()) {
            requestFitnessPermission()
            return
        }*/

        // Invoke the History API to fetch the data with the query
        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readData(queryFitnessData())
                .addOnSuccessListener { dataReadResponse ->
                    // For the sake of the sample, we'll print the data so we can see what we just
                    // added. In general, logging fitness information should be avoided for privacy
                    // reasons.
                    printData(dataReadResponse, result)
                    println("Todays dataReadResponse -- " + dataReadResponse)
                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.e(TAG, "There was a problem reading the historic data.", e)
                            }
                        })
    }

    /**
     * Returns a [DataReadRequest] for all step count changes in the past week.
     */
    fun queryFitnessData(): DataReadRequest {
        // [START build_read_data_request]
        // Setting a start and end date using a range of 1 week working backwards using today's
        // start of the day (AshvaID night). This ensures that the buckets are in line with the days.
        val dt = DateTime().withTimeAtStartOfDay()
        val endTime = dt.millis
        val startTime = dt.minusWeeks(1).millis

        return DataReadRequest.Builder()
                // The data request can specify multiple data types to return, effectively
                // combining multiple data queries into one call.
                // In this example, it's very unlikely that the request is for several hundred
                // datapoints each consisting of a few steps and a timestamp.  The more likely
                // scenario is wanting to see how many steps were walked per day, for 7 days.
                .aggregate(ESTIMATED_STEP_DELTAS, DataType.AGGREGATE_STEP_COUNT_DELTA)
                // Analogous to a "Group By" in SQL, defines how data should be aggregated.
                // bucketByTime allows for a time span, whereas bucketBySession would allow
                // bucketing by "sessions", which would need to be defined in code.
                .bucketByTime(1, TimeUnit.DAYS)
                .setTimeRange(startTime, endTime, TimeUnit.MILLISECONDS)
                .build()
    }

    fun printData(dataReadResult: DataReadResponse, returnResult: Result) {
        val result = StringBuilder()
        // [START parse_read_data_result]
        // If the DataReadRequest object specified aggregated data, dataReadResult will be returned
        // as buckets containing DataSets, instead of just DataSets.

        val map = HashMap<String, Double>()

        val rootObject= JSONObject()


        if (dataReadResult.buckets.size > 0) {
            Log.i(TAG, "Number of returned buckets of DataSets is: " + dataReadResult.buckets.size)
            for (bucket in dataReadResult.buckets) {
                val dataSets = bucket.dataSets

               /* for ((index, value) in dataSets.withIndex()) {
                    println("rootObject  $index: $value")
                    rootObject.put(index.toString(), formatDataSet(value))
                }*/


                for ((index, value) in dataSets.withIndex()) {
                    println("the element outside at $index is ${formatDataSet(value)}")

                    //var day = formatDataSet(value);
                    val day = formatDataSet(value).substringBefore(':')
                    val steps = formatDataSet(value).substringAfter(':')
                    rootObject.put(day, steps)
                }

                /*dataSets.forEachIndexed { i, element ->
                    println("rootObject forEachIndexed inside $i: ${formatDataSet(element)}")
                }*/


                for (dataSet in dataSets) {
                    result.append(formatDataSet(dataSet))
                }
            }
        } else if (dataReadResult.dataSets.size > 0) {
            Log.i(TAG, "Number of returned DataSets is: " + dataReadResult.dataSets.size)
            for (dataSet in dataReadResult.dataSets) {
                result.append(formatDataSet(dataSet))
            }
        }

        println("Todays RESULT rootObject -- " + rootObject)

        println("Todays RESULT -- " + result)
        activity.runOnUiThread {
            returnResult.success(rootObject.toString())
        }

        // [END parse_read_data_result]
        //weekCounter.setText(result)
    }

    /**
     * Format the dataset value to a string; Mon: 1000
     *
     * @param dataSet
     * @return formatted string
     */
    private fun formatDataSet(dataSet: DataSet): String {
        val result = StringBuilder()

        for (dp in dataSet.dataPoints) {
            // Get the day of the week JodaTime property
            val sDT = DateTime(dp.getStartTime(TimeUnit.MILLISECONDS))
            val eDT = DateTime(dp.getEndTime(TimeUnit.MILLISECONDS))

            /*result.append(
                    String.format(
                            Locale.ENGLISH,
                            "%s %s to %s %s\n",
                            sDT.dayOfWeek().asShortText,
                            sDT.toLocalTime().toString("HH:mm"),
                            eDT.dayOfWeek().asShortText,
                            eDT.toLocalTime().toString("HH:mm")
                    )
            )*/

            result.append(
                    String.format(
                            Locale.ENGLISH,
                            "%s:%s",
                            sDT.dayOfWeek().asShortText,
                            dp.getValue(dp.dataType.fields[0]).toString(),
                            dp.dataType.fields[0].name))
        }

        return result.toString()
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == GOOGLE_FIT_PERMISSIONS_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                recordData { success ->
                    Log.i(TAG, "Record data success: $success!")

                    if (success)
                        deferredResult?.success(true)
                    else
                        deferredResult?.error("no record", "Record data operation denied", null)

                    deferredResult = null
                }
            } else {
                deferredResult?.error("canceled", "User cancelled or app not authorized", null)
                deferredResult = null
            }

            return true
        }

        return false
    }

    private fun connect(result: Result) {
        val fitnessOptions = getFitnessOptions()

        if (!GoogleSignIn.hasPermissions(GoogleSignIn.getLastSignedInAccount(activity), fitnessOptions)) {
            deferredResult = result

            GoogleSignIn.requestPermissions(
                    activity,
                    GOOGLE_FIT_PERMISSIONS_REQUEST_CODE,
                    GoogleSignIn.getLastSignedInAccount(activity),
                    fitnessOptions)
        } else {
            result.success(true)
        }
    }

    private fun recordData(callback: (Boolean) -> Unit) {
        Fitness.getRecordingClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .subscribe(dataType)
                .addOnSuccessListener {
                    callback(true)
                }
                .addOnFailureListener {
                    callback(false)
                }
    }


    private fun getHeartRateData(result: Result) {
        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.TYPE_HEART_POINTS)
                .addOnSuccessListener { dataSet ->


                    if (dataSet.isEmpty()) {
                        //val cal = dataSet.dataPoints[0].getValue(Field.FIELD_DISTANCE).asFloat();
                        val map = HashMap<String, Double>()
                        // map["value"] = count.asInt().toDouble()

                        map["heartrate"] = 0.0f.toDouble();

                        activity.runOnUiThread {
                            result.success(map)
                        }

                    } else {
                        val cal = dataSet.dataPoints[0].getValue(Field.FIELD_INTENSITY).asFloat();
                        val map = HashMap<String, Double>()
                        // map["value"] = count.asInt().toDouble()

                        map["heartrate"] = cal.toDouble();

                        activity.runOnUiThread {
                            result.success(map)
                        }

                    }



                   /* val calories = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_INTENSITY).asInt()).toLong()


                    //val cal = dataSet.dataPoints[0].getValue(Field.FIELD_INTENSITY).asFloat();
                    val map = HashMap<String, Double>()

                    map["heartrate"] = calories.toDouble();*/

                    /*val total = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_DISTANCE).asInt()).toLong()

                    println("Todays count getDistanceData - " + String.format(Locale.ENGLISH, "%d", total))
                    //counter.setText(String.format(Locale.ENGLISH, "%d", total))

                    val map = HashMap<String, Double>()
                    // map["value"] = count.asInt().toDouble()

                    map["distance"] = total.toDouble()*/


                    /*activity.runOnUiThread {
                        result.success(map)
                    }*/


                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })

    }

    private fun getDistanceData(result: Result) {
        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_DISTANCE_DELTA)
                .addOnSuccessListener { dataSet ->


                    if (dataSet.isEmpty()) {
                        //val cal = dataSet.dataPoints[0].getValue(Field.FIELD_DISTANCE).asFloat();
                        val map = HashMap<String, Double>()
                        // map["value"] = count.asInt().toDouble()

                        map["distance"] = 0.0f.toDouble();

                        activity.runOnUiThread {
                            result.success(map)
                        }

                    } else {
                        val cal = dataSet.dataPoints[0].getValue(Field.FIELD_DISTANCE).asFloat();
                        val map = HashMap<String, Double>()
                        // map["value"] = count.asInt().toDouble()

                        map["distance"] = cal.toDouble();

                        activity.runOnUiThread {
                            result.success(map)
                        }

                    }


                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })

    }

    private fun getMoveInMinData(result: Result) {
        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_MOVE_MINUTES)
                .addOnSuccessListener { dataSet ->

                    val total = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_DURATION).asInt()).toLong()

                    println("Todays count new getMoveInMIn - " + String.format(Locale.ENGLISH, "%d", total))
                    //counter.setText(String.format(Locale.ENGLISH, "%d", total))

                    val map = HashMap<String, Double>()
                    // map["value"] = count.asInt().toDouble()

                    map["move"] = total.toDouble()


                    activity.runOnUiThread {
                        result.success(map)
                    }
                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })
    }


    private fun getCaloriesData(result: Result) {
        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_CALORIES_EXPENDED)
                .addOnSuccessListener { dataSet ->


                    //                    float total_cal = 0;
//                    total_cal = totalSet.isEmpty()
//                    ? 0
//                    : totalSet.getDataPoints().get(0).getValue(Field.FIELD_CALORIES).asFloat();
//                }


                    if (dataSet.isEmpty()) {
                        val cal = dataSet.dataPoints[0].getValue(Field.FIELD_CALORIES).asFloat();
                        val map = HashMap<String, Float>()
                        // map["value"] = count.asInt().toDouble()
                        map["calories"] = 0.0f;
                        activity.runOnUiThread {
                            result.success(map)
                        }

                    } else {
                        val cal = dataSet.dataPoints[0].getValue(Field.FIELD_CALORIES).asFloat();
                        val map = HashMap<String, Float>()
                        // map["value"] = count.asInt().toDouble()

                        map["calories"] = cal;

                        activity.runOnUiThread {
                            result.success(map)
                        }
                    }


                    /*  val total = (if (dataSet.isEmpty)
                          0
                      else
                          dataSet.dataPoints[0].getValue(Field.FIELD_CALORIES).asFloat()

                      //println("Todays count new getCaloriesData - " + String.format(Locale.ENGLISH, "%d", total))
                      //counter.setText(String.format(Locale.ENGLISH, "%d", total))

                      val map = HashMap<String, String>()
                      // map["value"] = count.asInt().toDouble()

                      map["calories"] = total; */


                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })
    }

    private fun getMoveInMIn(result: Result) {
        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_MOVE_MINUTES)
                .addOnSuccessListener { dataSet ->

                    val total = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_DURATION).asInt()).toLong()

                    println("Todays count new getMoveInMIn - " + String.format(Locale.ENGLISH, "%d", total))
                    //counter.setText(String.format(Locale.ENGLISH, "%d", total))

                    val map = HashMap<String, Double>()
                    // map["value"] = count.asInt().toDouble()

                    map["move"] = total.toDouble()


                    activity.runOnUiThread {
                        result.success(map)
                    }
                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })

    }

    private fun getYesterdaysStepsTotal(result: Result) {

        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_MOVE_MINUTES)
                .addOnSuccessListener { dataSet ->

                    val totalMoveInMin = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_DURATION).asInt()).toLong()


                    println("Todays move in min - " + String.format(Locale.ENGLISH, "%d", totalMoveInMin))
                    //counter.setText(String.format(Locale.ENGLISH, "%d", total))

                    //map["move"] = totalMoveInMin.toDouble();

                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })


        Fitness.getHistoryClient(activity, GoogleSignIn.getLastSignedInAccount(activity)!!)
                .readDailyTotal(DataType.AGGREGATE_STEP_COUNT_DELTA)
                .addOnSuccessListener { dataSet ->

                    val total = (if (dataSet.isEmpty)
                        0
                    else
                        dataSet.dataPoints[0].getValue(Field.FIELD_STEPS).asInt()).toLong()

                    println("Todays count new - " + String.format(Locale.ENGLISH, "%d", total))
                    //counter.setText(String.format(Locale.ENGLISH, "%d", total))

                    val map = HashMap<String, Double>()
                    // map["value"] = count.asInt().toDouble()

                    map["value"] = total.toDouble()


                    activity.runOnUiThread {
                        result.success(map)
                    }


                }
                .addOnFailureListener(
                        object : OnFailureListener {
                            override fun onFailure(e: Exception) {
                                Log.w(TAG, "There was a problem getting the step count.", e)
                            }
                        })


        /*val gsa = GoogleSignIn.getAccountForExtension(activity, getFitnessOptions())
        // today
        val newStartCall = GregorianCalendar()
        // reset hour, minutes, seconds and millis
        newStartCall.set(Calendar.HOUR_OF_DAY, 0)
        newStartCall.set(Calendar.MINUTE, 0)
        newStartCall.set(Calendar.SECOND, 0)
        newStartCall.set(Calendar.MILLISECOND, 0)
        System.out.println("todays start date AshvaID night newStartCall " + newStartCall)

        val startCal = GregorianCalendar()
        startCal.add(Calendar.DAY_OF_YEAR, -1)
        startCal.set(Calendar.HOUR_OF_DAY, 0)
        startCal.set(Calendar.MINUTE, 0)
        startCal.set(Calendar.SECOND, 0)

        System.out.println("todays start cal old startCal " + startCal.timeInMillis)

        val cal = Calendar.getInstance()
        val now = Date()
        cal.time = now
        val endTime = cal.timeInMillis
        cal.add(Calendar.DAY_OF_YEAR, -1)
        val startTime = cal.timeInMillis

        val dateFormat2 = DateFormat.getDateInstance()
        System.out.println("Range Start: " + dateFormat2.format(startTime))
        System.out.println("Range End: " + dateFormat2.format(endTime))


        val endCal = GregorianCalendar(
                newStartCall.get(Calendar.YEAR),
                newStartCall.get(Calendar.MONTH),
                newStartCall.get(Calendar.DAY_OF_MONTH),
                23,
                59)

        System.out.println("todays end date AshvaID night endCal " + endCal.timeInMillis)


        val request = DataReadRequest.Builder()
                .aggregate(dataType, aggregatedDataType)
                .bucketByTime(1, TimeUnit.DAYS)
                .setTimeRange(newStartCall.timeInMillis, endCal.timeInMillis, TimeUnit.MILLISECONDS)
                .build()

        val response = Fitness.getHistoryClient(activity, gsa).readData(request)

        val dateFormat = DateFormat.getDateInstance()
        val dayString = dateFormat.format(Date(newStartCall.timeInMillis))

        Thread {
            try {
                val readDataResult = Tasks.await<DataReadResponse>(response)
                Log.d(TAG, "buckets count: ${readDataResult.buckets.size}")

                if (!readDataResult.buckets.isEmpty()) {
                    val dp = readDataResult.buckets[0].dataSets[0].dataPoints[0]
                    val count = dp.getValue(aggregatedDataType.fields[0])

                    Log.d(TAG, "returning $count steps for $dayString")
                    val map = HashMap<String, Double>()
                    map["value"] = count.asInt().toDouble()

                    activity.runOnUiThread {
                        result.success(map)
                    }

                } else {
                    activity.runOnUiThread {
                        result.error("No data", "No data found for $dayString", null)
                    }
                }
            } catch (e: Throwable) {
                Log.e(TAG, "failed: ${e.message}")

                activity.runOnUiThread {
                    result.error("failed", e.message, null)
                }
            }

        }.start()*/
    }

    private fun getFitnessOptions() = FitnessOptions.builder()
            .addDataType(dataType, FitnessOptions.ACCESS_READ)
            .build()
}

