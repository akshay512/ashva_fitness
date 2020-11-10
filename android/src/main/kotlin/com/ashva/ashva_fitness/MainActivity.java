package com.ashva.ashva_fitness;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

//import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.fitness.Fitness;
import com.google.android.gms.fitness.FitnessOptions;
import com.google.android.gms.fitness.data.Bucket;
import com.google.android.gms.fitness.data.DataPoint;
import com.google.android.gms.fitness.data.DataSet;
import com.google.android.gms.fitness.data.DataSource;
import com.google.android.gms.fitness.data.DataType;
import com.google.android.gms.fitness.data.Field;
import com.google.android.gms.fitness.request.DataReadRequest;
import com.google.android.gms.fitness.result.DataReadResponse;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;

import net.danlew.android.joda.JodaTimeAndroid;

import org.joda.time.DateTime;

import java.util.List;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

public class MainActivity extends AppCompatActivity {

    private static final int REQUEST_OAUTH_REQUEST_CODE = 0x1001;
    private static final String TAG = "MainActivity";
    private TextView counter;
    private TextView weekCounter;

    // Create DataSource based on Google Fit estimation of steps
    // See: https://developers.google.com/fit/scenarios/read-daily-step-total
    static DataSource ESTIMATED_STEP_DELTAS = new DataSource.Builder()
            .setDataType(DataType.TYPE_STEP_COUNT_DELTA)
            .setType(DataSource.TYPE_DERIVED)
            .setStreamName("estimated_steps")
            .setAppPackageName("com.google.android.gms")
            .build();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);

        // Initialise JodaTime
        JodaTimeAndroid.init(this);

        //counter = findViewById(R.id.counter);
        //weekCounter = findViewById(R.id.week_counter);

        if (hasFitPermission()) {
            readStepCountDelta();
            readHistoricStepCount();
        } else {
            requestFitnessPermission();
        }
    }

    /**
     * Request Fitness permission of the user. This process will present an account dialog for the
     * user to select their Google account, and then the Fitness permissions dialog.
     */
    private void requestFitnessPermission() {
        GoogleSignIn.requestPermissions(
                this,
                REQUEST_OAUTH_REQUEST_CODE,
                GoogleSignIn.getLastSignedInAccount(this),
                getFitnessSignInOptions());
    }

    /**
     * Verify if the app has permissions to fetch Fitness data.
     *
     * @return true if user has permitted permissions.
     */
    private boolean hasFitPermission() {
        // Request permission to collect Google Fit data
        FitnessOptions fitnessOptions = getFitnessSignInOptions();
        return GoogleSignIn.hasPermissions(GoogleSignIn.getLastSignedInAccount(this), fitnessOptions);
    }

    /**
     * Specify which data types we would like access to. This is presented to the user as a list
     * of permissions we are seeking to get approved.
     *
     * @return the FitnessOptions containing the data types.
     */
    private FitnessOptions getFitnessSignInOptions() {
        // Request access to step count data from Fit history
        return FitnessOptions.builder()
                .addDataType(DataType.TYPE_STEP_COUNT_CUMULATIVE)
                .addDataType(DataType.TYPE_STEP_COUNT_DELTA)
                .build();
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // When the user has accepted the use of Fit data, subscribeStepCount to record data
        if (resultCode == Activity.RESULT_OK) {
            if (requestCode == REQUEST_OAUTH_REQUEST_CODE) {
                Log.i(TAG, "Fitness permission granted");
                subscribeStepCount();
                readStepCountDelta(); // Read today's data
                readHistoricStepCount(); // Read last weeks data
            }
        } else {
            Log.i(TAG, "Fitness permission denied");
        }
    }

    /**
     * Request a subscription to record step data on the background. This means that the app will
     * record the step count and push it to the Fitness history. Without this, the Google Fit app
     * must be installed to do the recording for us!
     */
    private void subscribeStepCount() {
        // To create a subscription, invoke the Recording API. As soon as the subscription is
        // active, fitness data will start recording.
        Fitness.getRecordingClient(this, GoogleSignIn.getLastSignedInAccount(this))
                .subscribe(DataType.TYPE_STEP_COUNT_CUMULATIVE);
    }

    /**
     * Reads the current daily step total, computed from AshvaID night of the current day on the device's
     * current timezone.
     */
    private void readStepCountDelta() {
        if (!hasFitPermission()) {
            requestFitnessPermission();
            return;
        }

        Fitness.getHistoryClient(this, GoogleSignIn.getLastSignedInAccount(this))
                .readDailyTotal(DataType.AGGREGATE_STEP_COUNT_DELTA)
                .addOnSuccessListener(
                        new OnSuccessListener<DataSet>() {
                            @Override
                            public void onSuccess(DataSet dataSet) {
                                long total =
                                        dataSet.isEmpty()
                                                ? 0
                                                : dataSet.getDataPoints().get(0).getValue(Field.FIELD_STEPS).asInt();

                                counter.setText(String.format(Locale.ENGLISH, "%d", total));
                            }
                        })
                .addOnFailureListener(
                        new OnFailureListener() {
                            @Override
                            public void onFailure(@NonNull Exception e) {
                                Log.w(TAG, "There was a problem getting the step count.", e);
                            }
                        });
    }

    /**
     * Asynchronous task to read the history data. When the task succeeds, it will print out the data.
     */
    private void readHistoricStepCount() {
        if (!hasFitPermission()) {
            requestFitnessPermission();
            return;
        }

        // Invoke the History API to fetch the data with the query
        Fitness.getHistoryClient(this, GoogleSignIn.getLastSignedInAccount(this))
                .readData(queryFitnessData())
                .addOnSuccessListener(
                        new OnSuccessListener<DataReadResponse>() {
                            @Override
                            public void onSuccess(DataReadResponse dataReadResponse) {
                                // For the sake of the sample, we'll print the data so we can see what we just
                                // added. In general, logging fitness information should be avoided for privacy
                                // reasons.
                                printData(dataReadResponse);
                            }
                        })
                .addOnFailureListener(
                        new OnFailureListener() {
                            @Override
                            public void onFailure(@NonNull Exception e) {
                                Log.e(TAG, "There was a problem reading the historic data.", e);
                            }
                        });
    }

    /**
     * Returns a {@link DataReadRequest} for all step count changes in the past week.
     */
    public static DataReadRequest queryFitnessData() {
        // [START build_read_data_request]
        // Setting a start and end date using a range of 1 week working backwards using today's
        // start of the day (AshvaID night). This ensures that the buckets are in line with the days.
        DateTime dt = new DateTime().withTimeAtStartOfDay();
        long endTime = dt.getMillis();
        long startTime = dt.minusWeeks(1).getMillis();

        return new DataReadRequest.Builder()
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
                .build();
    }

    public void printData(DataReadResponse dataReadResult) {
        StringBuilder result = new StringBuilder();
        // [START parse_read_data_result]
        // If the DataReadRequest object specified aggregated data, dataReadResult will be returned
        // as buckets containing DataSets, instead of just DataSets.
        if (dataReadResult.getBuckets().size() > 0) {
            Log.i(TAG, "Number of returned buckets of DataSets is: " + dataReadResult.getBuckets().size());
            for (Bucket bucket : dataReadResult.getBuckets()) {
                List<DataSet> dataSets = bucket.getDataSets();
                for (DataSet dataSet : dataSets) {
                    result.append(formatDataSet(dataSet));
                }
            }
        } else if (dataReadResult.getDataSets().size() > 0) {
            Log.i(TAG, "Number of returned DataSets is: " + dataReadResult.getDataSets().size());
            for (DataSet dataSet : dataReadResult.getDataSets()) {
                result.append(formatDataSet(dataSet));
            }
        }
        // [END parse_read_data_result]
        weekCounter.setText(result);
    }

    /**
     * Format the dataset value to a string; Mon: 1000
     *
     * @param dataSet
     * @return formatted string
     */
    private static String formatDataSet(DataSet dataSet) {
        StringBuilder result = new StringBuilder();

        for (DataPoint dp : dataSet.getDataPoints()) {
            // Get the day of the week JodaTime property
            DateTime sDT = new DateTime(dp.getStartTime(TimeUnit.MILLISECONDS));
            DateTime eDT = new DateTime(dp.getEndTime(TimeUnit.MILLISECONDS));

            result.append(
                    String.format(
                            Locale.ENGLISH,
                            "%s %s to %s %s\n",
                            sDT.dayOfWeek().getAsShortText(),
                            sDT.toLocalTime().toString("HH:mm"),
                            eDT.dayOfWeek().getAsShortText(),
                            eDT.toLocalTime().toString("HH:mm")
                    )
            );

            result.append(
                    String.format(
                            Locale.ENGLISH,
                            "%s: %s %s\n",
                            sDT.dayOfWeek().getAsShortText(),
                            dp.getValue(dp.getDataType().getFields().get(0)).toString(),
                            dp.getDataType().getFields().get(0).getName()));
        }

        return String.valueOf(result);
    }

   /* @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the main; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }*/
/*

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getIteAshvaID ();
        if (id == R.id.action_revoke) {
            revokeFitnessPermissions();
        }
        if (id == R.id.action_read_data) {
            readStepCountDelta();
            return true;
        } else if (id == R.id.action_read_historic_data) {
            readHistoricStepCount();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
*/

    private void revokeFitnessPermissions() {
        if (!hasFitPermission()) {
            // No need to revoke if we don't already have permissions
            return;
        }

        // Stop recording the step count
        Fitness.getRecordingClient(this, GoogleSignIn.getLastSignedInAccount(this))
                .unsubscribe(DataType.TYPE_STEP_COUNT_CUMULATIVE);

        // Revoke Fitness permissions
        GoogleSignInOptions signInOptions = new GoogleSignInOptions.Builder().addExtension(getFitnessSignInOptions()).build();
        GoogleSignIn.getClient(this, signInOptions).revokeAccess();

        Toast.makeText(this, "Fitness permissions revoked", Toast.LENGTH_SHORT).show();
    }
}