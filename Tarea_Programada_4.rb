require 'rubygems'
require 'sinatra'
require 'hpricot'
require 'open-uri'

$Informacion = []

## Clase para inicializar las variables y tener acceso a ellas
class Inicializar
		@Url
		@Banda
		@Album
		@Img
		
		attr_reader :Url, :Banda, :Album, :Img
		attr_writer :Url, :Banda, :Album, :Img

	def initialize(url, banda,album, img)
		@Url=url
		@Banda=banda
		@Album=album
		@Img=img	
	end



end



class Buscar
		
## Metodo que busca y almacena los url de los 10 primeros resultados.
	def busqueda(campo)
		tag="http://www.bandcamp.com/tag/"
		tag+=campo
		doc=Hpricot(open(tag))
		puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		i=4
		j=0
		arreglourl=doc.search("//a").map {|a| a[:href]}
		arreglobanda= doc.search("li[@class='item']").map{|e|
		resultadobanda = Hpricot( e.to_s ) 
		resultadobanda.search("div[@class='itemsubtext']").inner_html}
		arregloalbum=doc.search("li[@class='item']").map{|e|
		resultadoalbum = Hpricot( e.to_s )
		resultadoalbum.at("a[@href]")['title']}
		lista=[]
		while i!=14 && j!=10	
			lista+=[[arreglourl[i],arreglobanda[j],arregloalbum[j]]]
			i+=1
			j+=1
		end	
		return lista
	end 

	
	def obtenerdatos(lista)
		i=0
		result=[]
		j=0
		cont=2
		arregloimg=[]
		while j!=10
			tag=lista[j][0]
			doc1=Hpricot(open(tag))
			arregloimg+=doc1.search("//link").map {|a| a[:href]}
			j+=1
		end
		arregloimg
		while i!=10
			result+=[lista[i]+[arregloimg[cont]]]
			datos=Inicializar.new(result[i][0],result[i][1],result[i][2],result[i][3])
			$Informacion+=[datos]
			cont+=9
			i+=1
			
		end
		##return result
		pantallas_resultados($Informacion)

	end
	def pantallas_resultados(informacion)
		$IMAGEN01=informacion[0].Img
		$BANDA01=informacion[0].Banda
		$ALBUM01=informacion[0].Album
		$URL01=informacion[0].Url

		$IMAGEN02=informacion[1].Img
		$BANDA02=informacion[1].Banda
		$ALBUM02=informacion[1].Album
		$URL02=informacion[1].Url

		$IMAGEN03=informacion[2].Img
		$BANDA03=informacion[2].Banda
		$ALBUM03=informacion[2].Album
		$URL03=informacion[2].Url

		$IMAGEN04=informacion[3].Img
		$BANDA04=informacion[3].Banda
		$ALBUM04=informacion[3].Album
		$URL04=informacion[3].Url

		$IMAGEN05=informacion[4].Img
		$BANDA05=informacion[4].Banda
		$ALBUM05=informacion[4].Album
		$URL05=informacion[4].Url

		$IMAGEN06=informacion[5].Img
		$BANDA06=informacion[5].Banda
		$ALBUM06=informacion[5].Album
		$URL06=informacion[5].Url

		$IMAGEN07=informacion[6].Img
		$BANDA07=informacion[6].Banda
		$ALBUM07=informacion[6].Album
		$URL07=informacion[6].Url

		$IMAGEN08=informacion[7].Img
		$BANDA08=informacion[7].Banda
		$ALBUM08=informacion[7].Album
		$URL08=informacion[7].Url
	
		$IMAGEN09=informacion[8].Img
		$BANDA09=informacion[8].Banda
		$ALBUM09=informacion[8].Album
		$URL09=informacion[8].Url

		$IMAGEN010=informacion[9].Img
		$BANDA010=informacion[9].Banda
		$ALBUM010=informacion[9].Album
		$URL010=informacion[9].Url
	end
			


end


@@busquedas = Buscar.new
get "/" do
	erb:hola
end

post '/' do            # Método que carga la pag de inicio y busqueda de imágenes
	erb :hola
end

post '/resultado%20busqueda' do
	@campo = params[:campo].to_s
	@@busquedas.obtenerdatos(@@busquedas.busqueda(@campo))
	redirect '/Resultados_Obtenidos'
end

get '/Resultados_Obtenidos' do   # Método que redirecciona a la pag de resultados en donde se muestran las imagenes.
	erb :result
end
