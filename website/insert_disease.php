<head>
   <title>Insert Country</title>
</head>
<body>
<link rel="stylesheet" href="assets/css/main.css" />
<?php
include 'open.php';

//Override the PHP configuration file to display all errors
//This is useful during development but generally disabled before release
//ini_set('error_reporting', E_ALL);
//ini_set('display_errors', true);

if (isset($_POST['disease3'])) {
    $disease= $_POST['disease3'];
}

if (isset($_POST['comm'])) {
    $comm = $_POST['comm'];
}

echo "<h2 style=\"text-align:center\">Add new Country</h2>";

//Determine if any input was actually collected
if (empty($disease) or empty($comm)) {
   echo "empty <br><br>";

} else {

   echo "<h3 style=\"text-align:center\">".$disease." ".$comm."</h3></br>";

   echo "<br><br>";
   //Prepare a statement that we can later execute. The ?'s are placeholders for
   //parameters whose values we will set before we run the query.
   if ($stmt = $conn->prepare("CALL InsertDisease(?, ?)")) {

      //Attach the ? in prepared statements to variables (even if those variables
      //don't hold the values we want yet).  First parameter is a list of types of
      //the variables that follow: 's' means string, 'i' means integer, 'd' means
      //double. E.g., for a statment with 3 ?'s, where middle parameter is an integer
      //and the other two are strings, the first argument included should be "sis".
      $comm = intval($comm);
      $stmt->bind_param("si", $disease, $comm);

      //Run the actual query
      if ($stmt->execute()) {

         //Store result set generated by the prepared statement
         $result = $stmt->get_result();

         print ($result->fetch_row());

         if ($result) {
            echo "<h3 style=\"text-align:center\"> Success </h3></br>";
         }
         else {
           echo "<h3 style=\"text-align:center\"> Failure </h3></br>";
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
window.onload = function() {
 
var chart = new CanvasJS.Chart("chartContainer", {
   animationEnabled: true,
   theme: "light2",
   title:{
      text: "Percentage of each government type affected in the associated year"
   },
   axisX: {
      title: "Government Type"
   },
   axisY: {
      title: "Percentage"
   },
   data: [{
      type: "column",
      dataPoints: <?php echo json_encode($data, JSON_NUMERIC_CHECK); ?>
   }]
});
chart.render();
 
}
</script>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="assets/js/canvasjs.min.js"></script>
</body>
