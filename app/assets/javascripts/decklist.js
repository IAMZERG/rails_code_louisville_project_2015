// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(".cardsearch").keyup(function (event) {
  event.preventDefault();
  $(".showing").hide();
  console.log("button pressed!");
  var theValue = $(this).val();
  var keyupContext = this;
  $.ajax({
    url: "https://api.magicthegathering.io/v1/cards?",
    dataType: 'json',
    type: "GET",
    data: {
      name: theValue
    }
  }).done(function (data) {
    $("#results").html("");
    console.log(data);
    data.query.search.forEach(function(item) {
      console.log(item);
      container.appendTo(keyupContext);
      var container = $("#results");
      var result = $("<li class='result'><a></a></li>").appendTo(container);
      console.log(result);
      $("a:empty").append(item.title)
      .attr("href", "http://http://gatherer.wizards.com/Pages/Search/Default.aspx?name=+["+theValue+"]")
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
  });
});
