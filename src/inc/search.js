        function init() {
            var options = {
                types: ["(cities)"]
            }
            var input = document.getElementById('search');
	        var autocomplete = new google.maps.places.Autocomplete(input,options);
        }

        google.maps.event.addDomListener(window, 'load', init);

        // When the Search Button is clicked, this will start to run.
        $("#btn").on("click", function() {

            //This pushes the data into the DB Tables "cities" & "search_history".
            //It will add a new city if it is a new search, increment the city if has been searched before,
            //and will connect it to the search history by its city_id.
            //Once a user is logged in, they should also have their user id connected so they could see
            //their own previous searches.

            //This way a report could be made about
            //Top Cities searches, How Many Searches in the Last 24 Hours, etc.
            var data = $('#searchBar :input').serializeArray();
            $.post($('#searchBar').attr("action"),data,
            function(info){
                console.log(info);
            });

            var city = $('#search').val()
            if(results) {
                results = "";
                $("#results > tbody").empty();
            }

            var url = "https://maps.googleapis.com/maps/api/geocode/json?address="+encodeURIComponent(city)+"&key=AIzaSyAMf1KTIzyqQqLf1QmNic4xcq7hGp_wE7s";
            console.log(url);
            $.getJSON(url, function(val) {
                if(val.results.length) {
                  var location = val.results[0].geometry.location
                  var lat = location.lat;
                  var lon = location.lng;
                  if($('#types').val() == "all")
                    var type = "'lodging','travel agency', 'shopping mall', 'bar', 'cafe', 'airport', 'movie theater', 'museum', 'mosque', 'church'"
                  else
                    var type = $('#types').val();

                  var request = {
                        location: new google.maps.LatLng(lat, lon),
                        radius: '100',
                        types: [type]
                    };

                    var container = document.getElementById('search');

                    var service = new google.maps.places.PlacesService(container);
                    service.nearbySearch(request, callback);

                    function callback(results, status) {

                        if (status == google.maps.places.PlacesServiceStatus.OK) {
                            results = quickSort(results,0,results.length - 1)
                            console.log("Sorted?",results.length-1)
                            console.log(results)

                            for (var i = results.length-1; i >= 0; i--) {
                                if($('#types').val() == "point_of_interest" && $.inArray('lodging', results[i].types[0])) {
                                    console.log("nope")
                                }
                                else {

                                console.log(results[i]);

                                if(!results[i].rating)
                                    results[i].rating = "N/A";

                                var button = $('<form method="post" action="inc/cart.php"><button type="button" class="addBtn" value="' + results[i].place_id + '">ADD</button>').on("click",
                                    function() {
                                        console.log($(this).attr("name"));
                                        addItem(this);

                                        $('added_message').html("Added to Your Itinerary!");
                                        $('added_message').fadeIn(1000).delay(1000).fadeOut("slow");
                                    });
                                $('#results > tbody')
                                    .append($('<tr id="thisRow">')
                                        .append($('<td>')
                                            .html(results[i].name.toUpperCase())
                                        )
                                        .append($('<td>')
                                            .html(results[i].vicinity)
                                        )
                                        // .append($('<td>')
                                        //     .html(function() {
                                        //         var j = results[i].types.length;
                                        //         console.log(j);
                                        //         var str = ""
                                        //         for(k=0;k<j;k++)
                                        //             str = str + results[i].types[k] + "<br/>";
                                        //         return str
                                        //     }))
                                        .append($('<td>')
                                                .html(results[i].rating)
                                        )
                                        .append($('<td>')
                                                .append(button)
                                        )
                                        // .append($('<tr style="display:none">')
                                        //     .html(results[i].)

                                );
                            }}
                        }
                    }
                }
              })
        })

        function quickSort(arr, left, right) {
           var len = arr.length,
           pivot,
           partitionIndex;

          if(left < right){
            pivot = right;
            partitionIndex = partition(arr, pivot, left, right);

           //sort left and right
           quickSort(arr, left, partitionIndex - 1);
           quickSort(arr, partitionIndex + 1, right);
          }
          return arr;
        }


        function partition(arr, pivot, left, right){
            if(!arr[pivot].rating)
                arr[pivot].rating = 0;
           var pivotValue = arr[pivot].rating,
               partitionIndex = left;

           for(var i = left; i < right; i++){
               if(!arr[i].rating)
                    arr[i].rating = 0;
                if(arr[i].rating < pivotValue){
                  swap(arr, i, partitionIndex);
                  partitionIndex++;
                }
          }
          swap(arr, right, partitionIndex);
          return partitionIndex;
        }


        function swap(arr, j, i){
           var temp = arr[i];
           arr[i] = arr[j];
           arr[j] = temp;
        }

        function addToData(city) {
                var data = $('#search :input').serializeArray();
                $.post($('#searchBar').attr("action"),data,
                function(info){
                    console.log(info);
                    // if(info == "Success!") {
                    //     // $('#newUserForm').css("display","none");
                    //     // $('message').html("You have been added! Welcome!")
                    //     // $('message').css({"color": "green","padding":"10px"})
                    // }

                });
                // clearInput();
        }

        $('#btn').submit( function() {
            return false;
        })

        function addItem(item){
            var data = $(item).val();
            $.post($(item).attr("action"),data,
                    function(info){
                        console.log(info);
                        // if(info == "Success!") {

                        // }

                    });

            $(item).submit( function() {
                return false;
            })
        }



