// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(".cardsearch").keyup(function (event) {
  event.preventDefault();
  $(".showing").hide();
  console.log("button pressed!");
  let inputValue = $(this).val();
  let keyupContext = this;
  $.ajax({
    url: "https://api.magicthegathering.io/v1/cards?name=",
    dataType: 'jsonp',
    type: "GET",
    data: {
      name: inputValue
    }
  }).done(function (data) {
    $("#results").html("");
    console.log(data);
    data.query.search.forEach(function(item) {
      console.log(item);
      container.appendTo(keyupContext);
      let container = $("#results");
      let result = $("<li class='result'><a></a></li>").appendTo(container);
      console.log(result);
      $("a:empty").append(item.title)
      .attr("href", "http://http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+["+inputValue+"]")
      .attr("target", "_blank");
      result.append(item.snippet + "...");


    });
    $("#results").fadeIn().addClass('showing');
    //$("#results").append("h1").append(item.title).append(item.snippet);
    //    //});
    //        //$("#results").html(data.query.search[5].snippet);
    //          });
    //          });
    //
    //
    //
