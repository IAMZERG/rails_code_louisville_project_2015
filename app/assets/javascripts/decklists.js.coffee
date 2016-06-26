# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("card-search").keyup(function (event) {
    event.preventDefault();
    $(".showing").hide();
    console.log("button pressed!");
    let inputValue = $("#wikisearch").val();
    $.ajax({
url: "https://api.magicthegathering.io/v1/cards?",
dataType: 'jsonp',
type: "GET",
data: {
format: "json",
action: "query",
list: "search",
srsearch: inputValue
}
}).done(function (data) {
  $("#results").html("");
  console.log(data);
  data.query.search.forEach(function(item) {
    console.log(item);
    let container = $("#results");
    let result = $("<div class='result'><a></a></div>").appendTo(container);
    console.log(result);
    $("a:empty").append(item.title)
    .attr("href", "https://wikipedia.org/wiki/"+item.title)
    .attr("target", "_blank");
    result.append(item.snippet + "...");


    });
  $("#results").fadeIn().addClass('showing');
  //$("#results").append("h1").append(item.title).append(item.snippet);
  //});
  //$("#results").html(data.query.search[5].snippet);
});
});


