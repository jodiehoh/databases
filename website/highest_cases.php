<head>
   <title>Highest Incidence of Any Disease</title>
</head>
<body>
<link rel="stylesheet" href="assets/css/main.css" />
<?php
include 'open.php';

//Override the PHP configuration file to display all errors
//This is useful during development but generally disabled before release
//ini_set('error_reporting', E_ALL);
//ini_set('display_errors', true);


echo "<h2 style=\"text-align:center\">Highest incidence of any Disease </h2>";

//Determine if any input was actually collected
if (false) {
   echo "empty <br><br>";

} else {

   //Prepare a statement that we can later execute. The ?'s are placeholders for
   //parameters whose values we will set before we run the query.
   if ($stmt = $conn->prepare("CALL HighCase()")) {

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
              echo "<table border =\"2px solid black\">";
              echo "<tr><td>Country</td><td>Disease</td><td>Year</td><td>Cases</td></tr>";

              while ($row = $result->fetch_row()) {
              // $arr[3] will be updated with each value from $arr...
                echo "<tr>";
                echo "<td>".$row[0]."</td>";
                echo "<td>".$row[1]."</td>";
		echo "<td>".$row[2]."</td>";
		echo "<td>".$row[3]."</td>";
                echo "</tr>";
              }
              echo "</table>";  
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
</script>

<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="assets/js/canvasjs.min.js"></script>
</body>
