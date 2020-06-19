import java.io.File;
import java.util.Calendar;
import java.util.Date;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.io.BufferedWriter; 

public aspect Logger {

    File file = new File("log.txt");
    Date cal;
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("**** User created ****");
    }
    pointcut retirarDinero() : call(* moneyWith*());
    before():retirarDinero(){
    	guardarArchivoeImprimir("Inicio de retiro dinero");
    }
    after():retirarDinero(){
    	guardarArchivoeImprimir("Fin de retiro dinero");
    }
    pointcut errorUser() : call(* errorUsuario*());
    after():errorUser(){
    	guardarArchivoeImprimir("Ocurrió un error al buscar al usuario.");
    }
    
    pointcut depositarDinero() : call(* moneyMakeTransac*());
    before():depositarDinero(){
    	guardarArchivoeImprimir("Inicio de deposito de dinero.");
    }
    after():depositarDinero(){
    	guardarArchivoeImprimir("Fin de deposito de dinero.");
    }
    
    private String conseguirTiempo() {
    	cal = Calendar.getInstance().getTime();
    	//Si en el futuro quiere agregar la fecha, se antepone a HH dd-MM-yyyy
    	SimpleDateFormat formateo = new SimpleDateFormat("HH:mm:ss");
    	return formateo.format(cal);
    }
    private void guardarArchivoeImprimir(String mensaje) {
    	String tiempo = conseguirTiempo();	
    	System.out.println("***"+tiempo+" "+mensaje+"***");
    	
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter(file,true))){
    		bw.append(tiempo + " --- " + mensaje+"\n");
    	}catch(IOException ex) {
    		System.out.println(ex.getMessage());
    	}
    }
}
