/*подключиться к Mongo из командной строки Linux и загрузить в Mongo текстовый JSON-файл;
*/
/usr/bin/mongoimport --host $APP_MONGO_HOST --port $APP_MONGO_PORT --db movies --collection tags --file /usr/local/share/netology/raw_data/simple_tags.json
/* ОТВЕТ-----------------------------
2019-02-19T22:32:27.775+0300	connected to: localhost:27017
2019-02-19T22:32:28.799+0300	imported 158680 documents
-----------------------------*/

/*подсчитайте число элементов в созданной коллекции tags в bd movies
*/
db.tags.count()
/* ОТВЕТ-----------------------------
158680
-----------------------------*/

/*подсчитайте число фильмов с конкретным тегом - woman
*/
db.tags.count({'name': 'woman'})
/* ОТВЕТ-----------------------------
19
-----------------------------*/

/*используя группировку данных ($groupby) вывести top-3 самых распространённых тегов
*/
db.tags.aggregate([{$group: {_id: "$name", tag_count: { $sum: 1 }}},{$sort:{tag_count: -1}},{$limit:3}])
/* ОТВЕТ-----------------------------
{ "_id" : "woman director", "tag_count" : 3115 }
{ "_id" : "independent film", "tag_count" : 1930 }
{ "_id" : "murder", "tag_count" : 1308 }
-------------------------------------*/
