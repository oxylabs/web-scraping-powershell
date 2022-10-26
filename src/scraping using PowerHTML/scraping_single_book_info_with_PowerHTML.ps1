$web_page = Invoke-WebRequest 'https://books.toscrape.com/catalogue/a-light-in-the-attic_1000/index.html'
 
$html = ConvertFrom-Html $web_page
 
$BookDetails=[System.Collections.ArrayList]::new()
 
$name_of_book =$html.SelectNodes('//li') | Where-Object { $_.HasClass('active') }
$name=$name_of_book.ChildNodes[0].innerText
$n = New-Object -TypeName psobject
$n | Add-Member -MemberType NoteProperty -Name Name -Value $name
$BookDetails+=$n
 
$table = $html.SelectNodes('//table') | Where-Object { $_.HasClass('table-striped') }
 
foreach ($row in $table.SelectNodes('tr'))
{
    $cnt += 1
    $name=$row.SelectSingleNode('th').innerText.Trim() 
    $value=$row.SelectSingleNode('td').innerText.Trim() -replace "\?", " "
    $new_obj = New-Object -TypeName psobject
    $new_obj | Add-Member -MemberType NoteProperty -Name $name -Value $value
    $BookDetails+=$new_obj 
}
 
Write-Output 'Extracted Table Information'
$table
 
Write-Output 'Extracted Book Details Parsed from HTML table'
$BookDetails