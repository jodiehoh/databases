<head>
   <title>Disease in Countries by Income</title>
</head>
<body>
<link rel="stylesheet" href="assets/css/main.css" />
<?php
include 'open.php';

//Override the PHP configuration file to display all errors
//This is useful during development but generally disabled before release
//ini_set('error_reporting', E_ALL);
//ini_set('display_errors', true);

if (isset($_POST['income7'])) {
    $income = $_POST['income7'];
}
if (isset($_POST['continent7'])) {
    $conti = $_POST['continent7'];
}
if (isset($_POST['cases7'])) {
    $cases = $_POST['cases7'];
}
if (isset($_POST['comm'])) {
    $comm = $_POST['comm'];
}
if (isset($_POST['year71'])) {
    $start = $_POST['year71'];
}
if (isset($_POST['year72'])) {
    $end = $_POST['year72'];
}

echo "<h2 style=\"text-align:center\">Disease in Countries by Income</h2>";

//Determine if any input was actually collected
if (empty($start) or empty($conti) or empty($end) or empty($income) or empty($cases) or empty($comm)) {
   echo "empty <br><br>";

} else {

   echo "<h3 style=\"text-align:center\">".$income." countries "." from ".$conti." with more than ".$cases." disease cases from ".$start." to ".$end."</h3></br>";

   echo "<br><br>";
   //Prepare a statement that we can later execute. The ?'s are placeholders for
   //parameters whose values we will set before we run the query.
   if ($stmt = $conn->prepare("CALL IncomeCommDisease(?, ?, ?, ?, ?, ?)")) {

      //Attach the ? in prepared statements to variables (even if those variables
      //don't hold the values we want yet).  First parameter is a list of types of
      //the variables that follow: 's' means string, 'i' means integer, 'd' means
      //double. E.g., for a statment with 3 ?'s, where middle parameter is an integer
      //and the other two are strings, the first argument included should be "sis".
      $comm = intval($comm);
      $stmt->bind_param("ssiiii", $income, $conti, $cases, $comm, $start, $end);

      //Run the actual query
      if ($stmt->execute()) {

         //Store result set generated by the prepared statement
         $result = $stmt->get_result();

         if ($result->num_rows == 0) {

            //Result contains no rows at all
            echo "No info.";

         } else {
              $data = array();
              


              while ($row = $result->fetch_row()) {
		      $obj = NULL;
		      $val = intval($row[1]);
                  $obj->label = $row[0];
                  $obj->y = $val;
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

<script>window.onload = function () {
 
var chart = new CanvasJS.Chart("chartContainer", {
  title: {
    text: "Case History"
},
	axisX: {
	interval: 1
},
  axisY: {
    title: "Number of Cases"
  },
  data: [{
    type: "line",
     dataPoints: <?php echo json_encode($data) ?>
  }]
});
chart.render();
 
}
</script>
<div id="chartContainer" style="height: 370px; max-width: 900px; margin: 0px auto;"></div>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="assets/js/canvasjs.min.js"></script>
</body>
