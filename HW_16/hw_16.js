

// 2. Поменяв подключение к базе данных, создать коллекцию orders_NAME (для уникальности - 
//     добавим ваше имя в название) со свойствами id, customer, product, amount, 
// city, используя следующие данные:

db.createCollection("Kolobova_131224_orders_NAME")

db.Kolobova_131224_orders_NAME.insertMany([
  {
		_id: 1,
		customer: 'Olga',
		product: 'Apple',
		amount: 15.5,
		city: 'Berlin'
	},
	{
		_id: 2,
		customer: 'Anna',
		product: 'Apple',
		amount: 10.5,
		city: 'Madrid'
	},
	{
		_id: 3,
		customer: 'Olga',
		product: 'Kiwi',
		amount: 9.6,
		city: 'Berlin'
	},
	{
		_id: 4,
		customer: 'Anton',
		product: 'Apple',
		amount: 20,
		city: 'Roma'
	},
	{
		_id: 5,
		customer: 'Olga',
		product: 'Banana',
		amount: 8,
		city: 'Madrid'
	},
	{
		_id: 6,
		customer: 'Petr',
		product: 'Orange',
		amount: 18.3,
		city: 'Paris'
	},
])



//3. Найти сколько всего было совершено покупок

db.Kolobova_131224_orders_NAME.countDocuments()

//4. Найти сколько всего раз были куплены яблоки

db.Kolobova_131224_orders_NAME.countDocuments({product: 'Apple'})

//5. Вывести идентификаторы трех самые дорогих покупок

db.Kolobova_131224_orders_NAME.find({},{_id: 1}).sort({amount: -1}).limit(3)

//6. Найти сколько всего покупок было совершено в Берлине

db.Kolobova_131224_orders_NAME.countDocuments({city: 'Berlin'})

//7. Найти количество покупок яблок в городах Берлин и Мадрид

db.Kolobova_131224_orders_NAME.countDocuments({$and: [{product: 'Apple'}, {city: {$in: ['Berlin', 'Madrid']}}]})

//8. Найти сколько было потрачено каждым покупателем

db.Kolobova_131224_orders_NAME.aggregate([
  {
    $group: {
      _id: "$customer",
      total: {
        $sum: "$amount"
      }
    }
  }
])

//9. Найти в каких городах совершала покупки Ольга

db.Kolobova_131224_orders_NAME.aggregate([
  {
    $match: {
      customer: "Olga"
    }
  },
  {
    $group: {
      _id: "$city"
    }
  }
])