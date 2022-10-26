$category_page_html=Invoke-RestMethod 'https://books.toscrape.com/catalogue/category/books/sports-and-games_17/index.html'
 
$reg_exp = '<h3><a href=.* title=\"(?<title>.*)\">.*<\/a><\/h3>(\n.*){13}<p class="price_color">(?<price>.*)<\/p>'
 
$all_matches = ($category_page_html | Select-String $reg_exp -AllMatches).Matches
 
$BookList = foreach ($book in $all_matches)
{
    [PSCustomObject]@{
        'title' = ($book.Groups.Where{$_.Name -like 'title'}).Value
        'price' = ($book.Groups.Where{$_.Name -like 'price'}).Value
       
    }
}
$BookList 