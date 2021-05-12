<head>
   <title>Starting Dose vs. Recent Dose</title>
</head>
<body>
<link rel="stylesheet" href="assets/css/main.css" />
<?php
include 'open.php';

//Override the PHP configuration file to display all errors
//This is useful during development but generally disabled before release
//ini_set('error_reporting', E_ALL);
//ini_set('display_errors', true);


echo "<h2 style=\"text-align:center\">Starting Dose vs. Recent Dose </h2>";

//Determine if any input was actually collected
if (false) {
   echo "empty <br><br>";

} else {

   //Prepare a statement that we can later execute. The ?'s are placeholders for
   //parameters whose values we will set before we run the query.
   if ($stmt = $conn->prepare("CALL MostRecentDoses()")) {

      //Attach the ? in prepared statements to variables (even if those variables
      //don't hold the values we want yet).  First parameter is a list of types of
      //the variables that follow: 's' means string, 'i' means integer, 'd' means
      //double. E.g., for a statment with 3 ?'s, where middle parameter is an integer
      //and the other two are strings, the first argument included should be "sis".

      //Run the actual query
      if ($stmt->execute()) {

         //Store result set generated by the prepared statement
         $result = $stmt->get_result();

         if ($result->num_rows == 0) {

            //Result contains no rows at all
            echo "No population history for this country";

         } else {
              $rows = array();
              $data = array();
        
        //Report result set by visiting each row in it
               while ($row = $result->fetch_row()) {
                  $obj = NULL;
                  $obj->label = $row[0]."(".$row[1].")";
                  $obj->y = array($row[2], $row[3]);
                  $json = $obj;
                  
                  array_push($data, $json);
                }   
         }   

         //We are done with the result set returned above, so free it
         $result->free_result();
      
      } else {

         //Call to execute failed, e.g. because server is no longer reachable,
   //or because supplied values are of the wrong type
         echo "Execute failed.<br>";
      }

      //Close down the prepared statement
      $stmt->close();

   } else {

       //A problem occurred when preparing the statement; check for syntax errors
       //and misspelled attribute names in the statement string.
      echo "Prepare failed.<br>";
      $error = $conn->errno . ' ' . $conn->error;
      echo $error; 
   }

}

//Close the connection created in open.php
$conn->close();
?>

<script>
window.onload = function () {
 
var chart = new CanvasJS.Chart("chartContainer", {
  title: {
    text: "Starting Dose and Most Recent Dose"
  },
  theme: "light1",
  animationEnabled: true,
  axisX: {
  	title: "Vaccine",
	interval: 1,
  },
  axisY: {
    title: "Number of Doses",
    includeZero: false
  },
  data: [
    {
      type: "rangeColumn",
      yValueFormatString: "##",
      toolTipContent: "{label}<br>Starting Dose: {y[0]}<br>Recent Dose: {y[1]}",
      dataPoints: <?php echo json_encode($data, JSON_NUMERIC_CHECK); ?>
    }
  ]
});
 
chart.render();
 
}
</script>

<div id="chartContainer" style="height: 370px; max-width: 1500px; margin: 0px auto;"></div>
<div id="ratiochartContainer" style="height: 370px; max-width: 920px; margin: 0px auto;"></div>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="assets/js/canvasjs.min.js"></script>
</body>