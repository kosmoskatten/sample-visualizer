// Load the visualization API and the piechart package.
google.load('visualization', '1', {packages: ['corechart']});

// Set a callback to run when the Google visualization API is loaded.
google.setOnLoadCallback(drawChart);

function drawChart()
{
    var jsonData = $.ajax({
        url: "/cats",
        dataType: "json",
        async: false
    }).responseText;

    alert(jsonData);
} 
