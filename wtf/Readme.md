# Projeto AM 2016-1: MVFCMddV e Multiclassificação
----------
O objetivo deste projeto é a implementação e avaliação do método de clusters MVFCMddV( Multi-view relacional fuzzy c-medoids vectors clustering algorithm), assim como a combinação dos classificadores para a classificação de dados utilizando várias funcionalidades(feauters supspaces).

Requirements
------------
Matlab and Michine Learning ToolBox

How to use it
-------------

Folder in: ./src/ 
 
### Metodos MVFCMddV:

	script_mvfcmddv_st.m  
	script_mvfcmddv_db.m
	script_mvfcmddv_img.m

### Combinação dos classificadores:

	script_multiple_cff.m

Outputs: ./out/

 	matG.dat % lista de medoids
	matLambda.dat % a matriz de pesos
	matU.dat % partição fuzzy
	matQ.dat % a partição hard
 
