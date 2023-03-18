# The Cocktail DB Flutter App

<h2>Task:</h2>

You have to make two screens listing and details. The listing screen has a search bar on top of it, which you have to use to fetch results from API. You only have one API so you'll have to take the data from listing to detail screen.
API Endpoint: https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rum
Recommended plugins:
1. Dio
2. Json_annonation
3. Json_serializable

The previous details screen is having an empty heart shaped icon now. This iconed button on pressed will be replaced to a filled heart shaped icon
and the particular drink in whose details are in will be fetched again from the API using the drinkId and the result Drink Object will be added to Cache/Local Storage.

Once we have some data in the favourite list. The home screen/listing screen should show a favourites navigation button with favourite count with it. Clicking on this should take us to the
favourite listing screen (from Cache). Once we click on any drink inside the favourite listing. We shall be redirected to its cached details screen while hitting the API also again, which will
refresh the same screen with the new data when. You have to perform this task with the help of a stream connection between the local storage and your bloc.

New API Endpoint: https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=12093

<table>
  <tr>
    <td>Listing Page</td>
     <td>Detail Page</td>
     <td>Detail Page</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/38591396/226085968-77db11d7-74e4-424a-b551-96d30b4f7c79.png" width=270></td>
    <td><img src="https://user-images.githubusercontent.com/38591396/226086000-da7208ea-e96b-46c2-9675-3870baaf9198.png" width=270></td>
    <td><img src="https://user-images.githubusercontent.com/38591396/226086007-9881a350-2b77-4991-90b1-b989bbe61823.png" width=270></td>
  </tr>
 </table>
