//
//  DataR.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 22/10/2020.
//

import Foundation



//build a model for data {latest meals for now}
struct RecipeModel: Decodable{
    
    
    static let mealCategories = [
        
        MealCategory(id: 1, image: "https://www.themealdb.com/images/category/beef.png", category: "Beef", description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients."),
        
        MealCategory(id: 2, image: "https://www.themealdb.com/images/category/chicken.png", category: "Chicken", description: "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets."),
        
        MealCategory(id: 3, image: "https://www.themealdb.com/images/category/dessert.png", category: "Dessert", description: "Dessert is a course that concludes a meal. The course usually consists of sweet foods, such as confections dishes or fruit, and possibly a beverage such as dessert wine or liqueur, however in the United States it may include coffee, cheeses, nuts, or other savory items regarded as a separate course elsewhere. In some parts of the world, such as much of central and western Africa, and most parts of China, there is no tradition of a dessert course to conclude a meal. The term dessert can apply to many confections, such as biscuits, cakes, cookies, custards, gelatins, ice creams, pastries, pies, puddings, and sweet soups, and tarts. Fruit is also commonly found in dessert courses because of its naturally occurring sweetness. Some cultures sweeten foods that are more commonly savory to create desserts."),
        
        MealCategory(id: 4, image: "https://www.themealdb.com/images/category/lamb.png", category: "Lamb", description: "Lamb, hogget, and mutton are the meat of domestic sheep (species Ovis aries) at different ages. A sheep in its first year is called a lamb, and its meat is also called lamb. The meat of a juvenile sheep older than one year is hogget; outside the USA this is also a term for the living animal. The meat of an adult sheep is mutton, a term only used for the meat, not the living animals. The term mutton is almost always used to refer to goat meat in the Indian subcontinent."),
        
        MealCategory(id: 5, image: "https://www.themealdb.com/images/category/miscellaneous.png", category: "Miscellaneous", description: "General foods that don't fit into another category"),
        
        MealCategory(id: 6, image: "https://www.themealdb.com/images/category/pasta.png", category: "Pasta", description: "Pasta is a staple food of traditional Italian cuisine, with the first reference dating to 1154 in Sicily. Also commonly used to refer to the variety of pasta dishes, pasta is typically a noodle made from an unleavened dough of a durum wheat flour mixed with water or eggs and formed into sheets or various shapes, then cooked by boiling or baking. As an alternative for those wanting a different taste, or who need to avoid products containing gluten, some pastas can be made using rice flour in place of wheat.[3][4] Pastas may be divided into two broad categories, dried (pasta secca) and fresh (pasta fresca)."),
    
        MealCategory(id: 7, image: "https://www.themealdb.com/images/category/pork.png", category: "Pork", description: "Pork is the culinary name for meat from a domestic pig (Sus scrofa domesticus). It is the most commonly consumed meat worldwide,[1] with evidence of pig husbandry dating back to 5000 BC. Pork is eaten both freshly cooked and preserved. Curing extends the shelf life of the pork products. Ham, smoked pork, gammon, bacon and sausage are examples of preserved pork. Charcuterie is the branch of cooking devoted to prepared meat products, many from pork. Pork is the most popular meat in Eastern and Southeastern Asia, and is also very common in the Western world, especially in Central Europe. It is highly prized in Asian cuisines for its fat content and pleasant texture. Consumption of pork is forbidden by Jewish and Muslim dietary law, a taboo that is deeply rooted in tradition, with several suggested possible causes. The sale of pork is limited in Israel and illegal in certain Muslim countries."),
        
        MealCategory(id: 8, image: "https://www.themealdb.com/images/category/seafood.png", category: "Seafood", description: "Seafood is any form of sea life regarded as food by humans. Seafood prominently includes fish and shellfish. Shellfish include various species of molluscs, crustaceans, and echinoderms. Historically, sea mammals such as whales and dolphins have been consumed as food, though that happens to a lesser extent in modern times. Edible sea plants, such as some seaweeds and microalgae, are widely eaten as seafood around the world, especially in Asia (see the category of sea vegetables). In North America, although not generally in the United Kingdom, the term seafood is extended to fresh water organisms eaten by humans, so all edible aquatic life may be referred to as seafood. For the sake of completeness, this article includes all edible aquatic life."),
        
        MealCategory(id: 9, image: "https://www.themealdb.com/images/category/side.png", category: "Side", description: "A side dish, sometimes referred to as a side order, side item, or simply a side, is a food item that accompanies the entrée or main course at a meal. Side dishes such as salad, potatoes and bread are commonly used with main courses throughout many countries of the western world. New side orders introduced within the past decade[citation needed], such as rice and couscous, have grown to be quite popular throughout Europe, especially at formal occasions (with couscous appearing more commonly at dinner parties with Middle Eastern dishes)."),

        MealCategory(id: 10, image: "https://www.themealdb.com/images/category/starter.png", category: "Starter", description: "An entrée in modern French table service and that of much of the English-speaking world (apart from the United States and parts of Canada) is a dish served before the main course of a meal; it may be the first dish served, or it may follow a soup or other small dish or dishes. In the United States and parts of Canada, an entrée is the main dish or the only dish of a meal. Historically, the entrée was one of the stages of the “Classical Order” of formal French table service of the 18th and 19th centuries. It formed a part of the “first service” of the meal, which consisted of potage, hors d’œuvre, and entrée (including the bouilli and relevé). The “second service” consisted of roast (rôti), salad, and entremets (the entremets sometimes being separated into a “third service” of their own). The final service consisted only of dessert."),
        
        MealCategory(id: 11, image: "https://www.themealdb.com/images/category/vegan.png", category: "Vegan", description: "Veganism is both the practice of abstaining from the use of animal products, particularly in diet, and an associated philosophy that rejects the commodity status of animals.[b] A follower of either the diet or the philosophy is known as a vegan (pronounced /ˈviːɡən/ VEE-gən). Distinctions are sometimes made between several categories of veganism. Dietary vegans (or strict vegetarians) refrain from consuming animal products, not only meat but also eggs, dairy products and other animal-derived substances.[c] The term ethical vegan is often applied to those who not only follow a vegan diet but extend the philosophy into other areas of their lives, and oppose the use of animals for any purpose.[d] Another term is environmental veganism, which refers to the avoidance of animal products on the premise that the harvesting or industrial farming of animals is environmentally damaging and unsustainable."),
        
        MealCategory(id: 12, image: "https://www.themealdb.com/images/category/vegetarian.png", category: "Vegetarian", description: "Vegetarianism is the practice of abstaining from the consumption of meat (red meat, poultry, seafood, and the flesh of any other animal), and may also include abstention from by-products of animal slaughter. Vegetarianism may be adopted for various reasons. Many people object to eating meat out of respect for sentient life. Such ethical motivations have been codified under various religious beliefs, as well as animal rights advocacy. Other motivations for vegetarianism are health-related, political, environmental, cultural, aesthetic, economic, or personal preference. There are variations of the diet as well: an ovo-lacto vegetarian diet includes both eggs and dairy products, an ovo-vegetarian diet includes eggs but not dairy products, and a lacto-vegetarian diet includes dairy products but not eggs. A vegan diet excludes all animal products, including eggs and dairy. Some vegans also avoid other animal products such as beeswax, leather or silk clothing, and goose-fat shoe polish."),
        
        MealCategory(id: 13, image: "https://www.freeiconspng.com/thumbs/breakfast-png/breakfast-png-free-download-11.png", category: "Breakfast", description: "Breakfast is the first meal of a day. The word in English refers to breaking the fasting period of the previous night. There is a strong likelihood for one or more typical, or traditional, breakfast menus to exist in most places, but their composition varies widely from place to place, and has varied over time, so that globally a very wide range of preparations and ingredients are now associated with breakfast."),

        
    
    ]
    
    
    static let areasLocal = [
        
        AreaLocal(id: 1,image: "https://cms.hostelworld.com/hwblog/wp-content/uploads/sites/2/2017/06/Ultimate-Guide-to-Canadian-Food-Poutine-@shannondidwhat.jpg",strArea: "Canadian",description: "Canadian cuisine varies widely depending on the regions of the nation. The four earliest cuisines of Canada have First Nations, English, Scottish and French roots, with the traditional cuisine of English "),
        
        AreaLocal(id: 2,image: "https://www.englishclub.com/images/vocabulary/food/chinese/chinese-food.jpg",strArea: "Chinese",description: "Chinese cuisine is an important part of Chinese culture, which includes cuisine originating from the diverse regions of China, as well as from Overseas Chinese who have settled in other parts of the world."),
        
        
        AreaLocal(id: 3,image: "https://www.cleopatraegypttours.com/wp-content/uploads/2018/12/Fuul.png",strArea: "Egyptian",description: "Egyptian cuisine is characterized by dishes such as ful medames, mashed fava beans; kushari, a mixture of lentils, rice, pasta, and other ingredients; molokhiya, chopped and cooked bush okra with garlic and coriander sauce; and feteer meshaltet. "),
        
        
        AreaLocal(id: 4,image: "https://i0.wp.com/orpheeway.com/wp-content/uploads/2018/10/Goat-cheese.jpg?fit=720%2C540&ssl=1",strArea: "Dutch",description: "Dutch cuisine is simple and straightforward, with many vegetables and little meat: breakfast and lunch are typically bread with toppings like cheese, while dinner is meat and potatoes, supplemented with seasonal vegetables. ... During the twentieth century, Dutch cuisine and diet changed."),
        
        
        AreaLocal(id: 5,image: "https://www.swedishnomad.com/wp-content/images/2018/09/greek-food-1.jpg",strArea: "Greek",description: "Greek cuisine is the cuisine of Greece and the Greek diaspora. In common with many other cuisines of the Mediterranean, it is founded on the triad of wheat, olive oil, and wine. It uses vegetables, olive oil, grains, fish, and meat, including pork, poultry, veal and beef, lamb, rabbit, and goat."),
        
        AreaLocal(id: 6,image: "https://www.englishclub.com/images/vocabulary/food/indian/indian-food-640.jpg",strArea: "Indian",description: "Indian cuisine consists of a variety of regional and traditional cuisines native to the Indian subcontinent. Given the diversity in soil, climate, culture, ethnic groups, and occupations, these cuisines vary substantially and use locally available spices, herbs, vegetables, and fruits."),
        
        
        
        
        
        
        
        
       
        
        AreaLocal(id: 7,image: "https://www.familysearch.org/blog/en/wp-content/uploads/sites/2/2020/07/french-meal-from-above.jpg",strArea: "French",description: "French cuisine consists of the cooking traditions and practices from France. French cuisine developed throughout the centuries influenced by the many surrounding cultures of Spain, Italy, Switzerland"),
        
        
        
        
        AreaLocal(id: 8,image: "https://www.maruha-nichiro.com/who_we_are/img/Japanese-food-culture_04.png",strArea: "Japanese",description: "Japanese cuisine encompasses the regional and traditional foods of Japan, which have developed through centuries of political, economic, and social changes. The traditional cuisine of Japan, washoku, lit. Japanese eating, is based on rice with miso soup and other dishes; there is an emphasis on seasonal ingredients."),
        
        AreaLocal(id: 9,image: "https://cdn-cf.tucantravel.com/images/Country-guide-Tucan-Travel/Kenya-tours-trips-holidays/food-and-drink-in-kenya/Food-and-drink-in-Kenya.jpg",strArea: "Kenyan",description: "Staples are maize and other cereals depending on the region, including millet and sorghum eaten with various meats and vegetables. The foods that are universally eaten in Kenya are ugali, sukuma wiki, and nyama choma. Kenya's coastal cuisine is unique and highly regarded throughout the country."),
        
        AreaLocal(id: 10,image: "https://www.christineabroad.com/images//2016/11/malaysian-food.jpg",strArea: "Malaysian",description: "Malaysian cuisine consists of cooking traditions and practices found in Malaysia, and reflects the multi-ethnic makeup of its population. The vast majority of Malaysia's population can roughly be divided among three major ethnic groups: Malays, Chinese and Indians."),
        
        AreaLocal(id: 11,image: "https://d3d7qmccklvqbw.cloudfront.net/wp-content/uploads/2019/06/borracha-tacos.jpg",strArea: "Mexican",description: "Mexican cuisine consists of the cooking cuisines and traditions of the modern state of Mexico. Its roots lie in a combination of Mesoamerican and Spanish cuisine. "),
        
        AreaLocal(id: 12,image: "https://localadventurer.com/wp-content/uploads/2015/11/what-to-eat-in-morocco.jpg",strArea: "Moroccan",description: "Moroccan cuisine is influenced by Morocco's interactions and exchanges with other cultures and nations over the centuries. Moroccan cuisine is usually a mix of Amazigh, Arab, Andalusian, and Mediterranean cuisines, with slight European and sub-Saharan influences."),
        
        AreaLocal(id: 13,image: "https://media.istockphoto.com/photos/homemade-polish-pierogis-with-sour-cream-picture-id486978329?k=6&m=486978329&s=612x612&w=0&h=F9DVUSIgnEc74CoXzQ2mT1qSRCm-Y-MKgQnvbdhBkC0=",strArea: "Polish",description: "Polish cuisine is a style of cooking and food preparation originating in or widely popular in Poland. Polish cuisine has evolved over the centuries to become very eclectic due to Poland's history and it shares many similarities with neighbouring German, Czech, Slovak and Silesian culinary traditions."),
        
        AreaLocal(id: 14,image: "https://www.expresstorussia.com/files/pages/013779.jpg",strArea: "Russian",description: "Russian cuisine is a collection of the different cooking traditions of the Russian people. The cuisine is diverse, with Northern and Eastern European, Caucasian, Central Asian, Siberian, and East Asian influences."),
        
        AreaLocal(id: 15,image: "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/00/a0000467/img/basic/a0000467_main.jpg?20170412181722&q=80&rw=750&rh=536",strArea: "Spanish",description: "Spanish cuisine consists of the cooking traditions and practices from Spain. Olive oil is heavily used in the Spanish cuisine, and it is the base of many vegetable sauces. Hallmark herbs include parsley, oregano, rosemary and thyme. The use of garlic has been noted as common to all Spanish cooking"),
        
        AreaLocal(id: 16,image: "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/00/a0000460/img/basic/a0000460_main.jpg?20170412181434&q=80&rw=750&rh=536",strArea: "Thai",description: "Thai cuisine is the national cuisine of Thailand. Thai cooking places emphasis on lightly prepared dishes with strong aromatic components and a spicy edge."),
        
        AreaLocal(id: 17,image: "https://lp-cms-production.imgix.net/features/2019/01/brik-tunisia-a13b095b32f2.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850",strArea: "Tunisian",description: "Tunisian cuisine, the cuisine of Tunisia, is a blend of Mediterranean and Berber cuisines. Its distinctive spiciness comes from the many civilizations which have ruled the land now known as Tunisia: Romans, Vandals, Byzantines, Arabs, Spanish, Turkish, Italians, French, and the native Punics-Berber people."),
        
        AreaLocal(id: 18,image: "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/00/a0000463/img/basic/a0000463_main.jpg?20170412181549&q=80&rw=750&rh=536",strArea: "Turkish",description: "Turkish cuisine is largely the heritage of Ottoman cuisine, which can be described as a fusion and refinement of Central Asian, Middle Eastern, Mediterranean, Eastern European and Balkan cuisines."),
        
        AreaLocal(id: 19,image: "https://iloveasiatour.com/wp-content/uploads/2019/01/Vietnamese-daily-meal1.jpg",strArea: "Vietnamese",description: "Vietnamese cuisine encompasses the foods and beverages of Vietnam, and features a combination of five fundamental tastes in overall meals. Each Vietnamese dish has a distinctive flavor which reflects one or more of these elements."),
    
        
        AreaLocal(id: 20,image: "https://i.ndtvimg.com/i/2015-07/pancake-625_625x350_41435922828.jpg",strArea: "American",description: "American cuisine reflects the history of the United States, blending the culinary contributions of various groups of people from around the world, including indigenous American Indians, African Americans, Asians, Europeans, Pacific Islanders, and Latin Americans."),
        
        AreaLocal(id: 21,image: "https://i.pinimg.com/736x/b2/4b/f0/b24bf065cc26d733e9ad1680fc85dc5c.jpg",strArea: "British",description: "British cuisine is the heritage of cooking traditions and practices associated with the United Kingdom. Although Britain has a rich indigenous culinary tradition, its colonial history has profoundly enriched its native cooking traditions."),
        
        AreaLocal(id: 22,image: "https://irepo.primecp.com/2017/01/315811/bigstock--127669325_ArticleImage-CategoryPage_ID-2061057.jpg?v=2061057",strArea: "Irish",description: "Irish cuisine is the style of cooking that originated from Ireland, an island in the North Atlantic; or was developed by the Irish people. It has evolved from centuries of social and political change, and the mixing of the different cultures in Ireland, predominantly from Great Britain and other European regions."),
        
        AreaLocal(id: 23,image: "https://i.ndtvimg.com/i/2016-07/pasta_625x350_51467797057.jpg",strArea: "Italian",description: "Italian cuisine is a Mediterranean cuisine consisting of the ingredients, recipes and cooking techniques developed across the Italian Peninsula since antiquity, and later spread around the world together with waves of Italian diaspora."),
        
        AreaLocal(id: 24,image: "https://img.theculturetrip.com/768x432/wp-content/uploads/2017/10/escovitch-5.jpg",strArea: "Jamaican",description: "What do Jamaicans eat for breakfast? ... Popular breakfast options include Johnny cake with salt mackerel, steamed cabbage and saltfish, ackee and saltfish with bammy, callaloo with ripe plantain and hard dough bread, cornmeal porridge, saltfish fritters, fried dumplings and Jamaican hot chocolate tea."),
        
    
    ]
    
}


//for latest meals end-point
class Dishes:ObservableObject, Decodable{
    
    var meals = [Recipe]()
    
    
}


class Recipe : ObservableObject, Decodable{
    
    var idMeal : String?
    var strMeal : String
    var strDrinkAlternate : String?
    var strCategory : String?
    var strArea : String?
    var strInstructions : String?
    var strMealThumb : String?
    var strTags : String?
    var strYoutube : String?
    var strIngredient1 : String?
    var strIngredient2 : String?
    var strIngredient3 : String?
    var strIngredient4 : String?
    var strIngredient5 : String?
    var strIngredient6 : String?
    var strIngredient7 : String?
    var strIngredient8 : String?
    var strIngredient9 : String?
    var strIngredient10 : String?
    var strIngredient11 : String?
    var strIngredient12 : String?
    var strIngredient13 : String?
    var strIngredient14 : String?
    var strIngredient15 : String?
    var strIngredient16 : String?
    var strIngredient17 : String?
    var strIngredient18 : String?
    var strIngredient19 : String?
    var strIngredient20 : String?
    var strMeasure1 : String?
    var strMeasure2 : String?
    var strMeasure3 : String?
    var strMeasure4 : String?
    var strMeasure5 : String?
    var strMeasure6 : String?
    var strMeasure7 : String?
    var strMeasure8 : String?
    var strMeasure9 : String?
    var strMeasure10 : String?
    var strMeasure11 : String?
    var strMeasure12 : String?
    var strMeasure13 : String?
    var strMeasure14 : String?
    var strMeasure15 : String?
    var strMeasure16 : String?
    var strMeasure17 : String?
    var strMeasure18 : String?
    var strMeasure19 : String?
    var strMeasure20 : String?
    var strSource : String?
    var dateModified : String?

}



class RecipeLocal: Identifiable{
    var idMeal : String?
    var strMeal : String?
    var strDrinkAlternate : String?
    var strCategory : String?
    var strArea : String?
    var strInstructions : [String] = []
    var strMealThumb : String = ""
    var strTags : String?
    var strYoutube : String?
    var ingredients : [IngredientsLocal] = []
    var strSource : String?
    var dateModified : String?
    var cookingInfo = CookingInfo()
    
    
    public init(){
        
    }

}


struct IngredientsLocal{
    var ingredient: String = ""
    var measure: String = ""
    var isAvailable:Bool = false
    
    init(ingredient: String, measure: String, isAvailable: Bool) {
        self.ingredient = ingredient
        self.measure = measure
        self.isAvailable = isAvailable
    }
}


class CookingInfo: Identifiable{
    
    var difficulty = ""
    var difficultyImage = ""
    var time = ""
    var timeImage = ""
    var type = ""
    var typeImage = ""
    var ingredientCount = ""
    var ingredientCountImage = ""

}


//getting areas available
struct AreaLocal: Identifiable{
    var id: Int
    var image:String = ""
    var strArea:String = ""
    var description:String = ""
}

//object for getting meal types
struct MealCategory: Identifiable{
    var id: Int
    var image:String = ""
    var category:String = ""
    var description:String = ""
}

//global object usually maps from AreaLocal or MealCategory
struct Explore: Hashable, Identifiable{
    var id: Int
    var image:String = ""
    var type:String = ""
    var description:String = ""
}

//global object usually maps from AreaLocal or MealCategory
class FilterMeals: ObservableObject, Decodable{
    var idMeal: String = ""
    var strMealThumb:String = ""
    var strMeal:String = ""
}

class FilterMealsResult: ObservableObject, Decodable{
    
    var meals = [FilterMeals]()
    
}


