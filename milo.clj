[:html
 [:head
  [:meta {:charset "UTF-8"}]
  [:title "Cal Herries"]
  [:meta {:name "description" :content "My personal site."}]
  [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
  [:link {:rel "stylesheet" :href "resources/public/css/app-components.css"}]
  [:link {:rel "stylesheet" :href "resources/public/css/app-utilities.css"}]

  [:link {:rel "stylesheet" :href "https://fonts.googleapis.com/css?family=Roboto+Slab:700"}]
  [:link {:rel "stylesheet" :href "https://fonts.googleapis.com/css?family=Crimson+Pro"}]]
 [:body {:class "pt-24 p-8 leading-7 text-gray-700"}
  [:pre [:code]] ; Hack for postcss to not purge these elements code
  [:div {:class "my-3"}
   (markdown "milo.md")]]]
