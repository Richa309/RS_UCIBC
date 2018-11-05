// from data.js
var tableData = data;

// YOUR CODE HERE!

// iterate through tbody.
// get reference to the tbody element, add input field and button

var $tbody = d3.select("tbody");
var $dateInput = d3.select("#datetime");
var $cityInput = d3.select("#city");
var $stateInput = d3.select("#state");
var $countryInput = d3.select("#country");
var $shapeInputer = d3.select("#shape");
var $searchButton = d3.select("#search");
var $resetButton = d3.select("#reset");
 
	 
	 
 
// add an event listener to searchbutton and resetbutton and add a function

$searchButton.addEventListener("click", searchData);
$resetButton.addEventListener("click", resetData);

// Set fileteredData to dataSet ; reset data to dataSet

var filteredData = tableData.filter(data => sighting.datatime === inputValue);
console.log(filteredData);
var resetData = dataSet;

//Set starting index and results per page
var startingIndex = 0;
var resultsPerPage = 1000;
 
// Insert the data in table 

var tbody = d3.select("tbody");
tableData.forEach((sighting) => {
 var row = tbody.append("tr");
 Object.entries(sighting).forEach(([key, value]) => {
   var cell = tbody.append("td");
   cell.text(value);
 });
});


function searchData(event){

	 // Prevent the page from refreshing
	 d3.event.preventDefault();


	var filteredDate = $dateInput.value()  
	if(filteredDate !=""){
		filteredData = dataSet.filter(function (data){
			var dataDate = tabledata.datetime;
			return dataDate ===filteredDate;
		});
	

	};
	
	var filteredCity = $cityInput.value.trim().toLowerCase();
  	if (filteredCity !="") {
    	filteredData = filteredData.filter(function(data) {
     		var dataCity = data.city.toLowerCase();
      		return dataCity === filteredCity;

		});
	};

	var filteredState = $stateInput.value.trim().toLowerCase();
	if (filteredState !="") {
		filteredData = filteredData.filter(function(data) {
			var dataState = data.set.toLowerCase();
			return dataState === filteredState;
		});
	};


	var filteredCountry = $countryInput.value.trim().toLowerCase();
	if(filteredCountry !="") {
		fileteredData = filteredData.filter(function(data) {
			var dataCountry = data.country.toLowerCase();
			return dataCountry === filteredCountry;
		});
	};

		renderTable();

	}

		function resetData() {
  		filteredData = dataSet;
  		$dateInput.value = "";
  		$cityInput.value = "";
  		$stateInput.value = "";
  		$countryInput.value = "";
 		$shapeInput.value = "";
  		renderTable();


	}

	function resetForm() {
		document.getElementById("myForm").reset();
	}

	// Render the table 

	renderTable();
