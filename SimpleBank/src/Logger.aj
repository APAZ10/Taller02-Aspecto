import java.io.File;
import java.util.Calendar;
import java.io.FileWriter;
import java.io.IOException;
import java.io.BufferedWriter; 

public aspect Logger {

    File file = new File("log.txt");
    Calendar cal;
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("**** User created ****");
    }
    pointcut retirarDinero() : call(* moneyWith*());
    after():retirarDinero(){
    	String tiempo = conseguirTiempo();
    	System.out.println("***retirar dinero***");
    	System.out.println(tiempo);
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter(file,true))){
    		bw.append("Retirar Dinero "+ tiempo + "\n");
    	}catch(IOException ex) {
    		System.out.println(ex.getMessage());
    	}
    }
    
    pointcut depositarDinero() : call(* moneyMakeTransac*());
    after():depositarDinero(){
    	String hora = conseguirTiempo();
    	System.out.println("***depositar dinero***");
    	System.out.println(hora);
    	try(BufferedWriter bw = new BufferedWriter(new FileWriter(file,true))){
    		bw.append("Depositar Dinero "+ hora+"\n");
    	}catch(IOException ex) {
    		System.out.println(ex.getMessage());
    	}
    }
    
    private String conseguirTiempo() {
    	cal = Calendar.getInstance();
    	int hora=cal.get(cal.HOUR_OF_DAY);
    	int min=cal.get(cal.MINUTE);
    	int seg=cal.get(cal.SECOND);
    	return hora+":"+min+":"+seg;
    }
}




















/*
public aspect Logger {
	
    pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    
    
    
}
*/
