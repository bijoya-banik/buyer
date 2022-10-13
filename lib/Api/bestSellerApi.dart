// const String apiKey = 'Your Key';
// //1
// const String bestSellerAPIURL = 'https://api.thecatapi.com/v1/breeds?';
// // 2
// //const String bestSellerImageAPIURL = 'https://api.thecatapi.com/v1/images/search?';
// // 3
// const String breedString = 'breed_id=';
// // 4
// const String apiKeyString = 'x-api-key=$apiKey';

// class CatAPI {
//   // 5
//   Future<dynamic> getCatBreeds() async {
//      // 6
//     Network network = Network('$bestSellerAPIURL$apiKeyString');
//     // 7
//     var catData = await network.getData();
//     return catData;
//   }
//   // 8
//   Future<dynamic> getCatBreed(String breedName) async {
//     Network network =
//         Network('$catImageAPIURL$breedString$breedName&$apiKeyString');
//     var catData = await network.getData();
//     return catData;
//   }
// }