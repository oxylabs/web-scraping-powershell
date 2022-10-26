$book_html = Invoke-RestMethod 'https://books.toscrape.com/catalogue/libertarianism-for-beginners_982/index.html'
 
$reg_exp = '<li class="active".*>(?<name>.*)</li>(.|\n)*<th>UPC</th><td.*>(?<upc_id>.*)</td>(.|\n)*<th>Product Type</th><td.*>(?<product_type>.*)</td>(.|\n)*<th>Price.*</th><td.*>(?<price>.*)</td>(.|\n)* <th>Availability</th>(.|\n)*<td.*>(?<availability>.*)</td>'
 
$all_matches = ($book_html | Select-String $reg_exp -AllMatches).Matches
 
$BookDetails =[PSCustomObject]@{
  'Name' = ($all_matches.Groups.Where{$_.Name -like 'name'}).Value
  'UPC_id' = ($all_matches.Groups.Where{$_.Name -like 'upc_id'}).Value
  'Product Type' = ($all_matches.Groups.Where{$_.Name -like 'product_type'}).Value
  'Price' = ($all_matches.Groups.Where{$_.Name -like 'price'}).Value
  'Availability' = ($all_matches.Groups.Where{$_.Name -like 'availability'}).Value
}
$BookDetails 