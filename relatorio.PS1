param($tipoDeExportacao)
$ErrorActionPreference = "Stop"

$nameEXPR = @{
	Label="Nome";
	Expression= {$_.Name}
}

$lengthExpr = @{
	Label="Tamanho"
	Expression= {"{0:N2}KB" -f ($_.length / 1KB)}
}

$params = $nameEXPR, $lengthExpr 

$resultado = 
	gci -Recurse -File |
		? Name -like "*test*" |
			select $params

if ($tipoDeExportacao -eq "HTML"){
	$estilos = Get-Content C:\Users\legen\style.css
	$styleTag = "<style> $estilos </style>"
	$tituloPagina= "Relatorio de Scripts"
	$TituloBody = "<h1>$tituloPagina</h1>"

	$resultado | ConvertTo-HTML -Head $styleTag -Title $tituloPagina -Body $TituloBody | Out-File C:\Users\legen\OneDrive\Desktop\Relatorio.html
} elseif ($tipoDeExportacao -eq "JSON"){
	$resultado | ConvertTo-JSON | Out-File C:\Users\legen\OneDrive\Desktop\Relatorio.json
}elseif ($tipoDeExportacao -eq "CSV"){
	$resultado | ConvertTo-CSV -NoTypeInformation| Out-File C:\Users\legen\OneDrive\Desktop\Relatorio.csv
}

