// task 1
// Коллекция imdb : Используя оператор $size , найдите фильмы, написанные 3 сценаристами (writers)
//  и снятые 2 режиссерами (directors)

db["imdb"].find({writers: {$size: 3}, directors: {$size: 2}}, {title: 1, writers: 1, directors: 1, _id: 0})

// task 2
// Коллекция bookings: Найдите адрес нахождения автомобиля с vin WME4530421Y135045 по самой последней дате
//  (и времени) final_date


db["bookings"].find({vin: "WME4530421Y135045"}, {vin: 1, final_address: 1, final_date: 1,_id: 0}).sort({ final_date: -1 }).limit(1)

//task3
// Коллекция bookings: подсчитайте, у скольких автомобилей при окончании аренды закончилось топливо (final_fuel)

db["bookings"].find({final_fuel: 0}).count()

// task 4
// Коллекция bookings: найдите номерной знак и vin номер авто, с самым большим километражом (distance)

db["bookings"].find({}, {vin: 1, plate: 1, distance: 1, _id: 0 }).sort({distance: -1}).limit(1)

// task 5
// Коллекция imdb. Найдите фильм с участием "Brad Pitt" с самым высоким рейтингом (imdb.rating)

db["imdb"].find({$and: [{cast: "Brad Pitt"}, {'imdb.rating': {$ne: ""}}]}, {title: 1, "imdb.rating": 1, cast: 1}).sort({"imdb.rating": -1}).limit(1)