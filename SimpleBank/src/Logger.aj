import java.io.File;
import java.util.Calendar;


public aspect Logger {

    File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("**** User created ****");
    }
    pointcut retirarDinero() : call(* moneyWith*());
    after():retirarDinero(){
    	int hora=cal.get(cal.HOUR_OF_DAY);
    	int min=cal.get(cal.MINUTE);
    	int seg=cal.get(cal.SECOND);
    	System.out.println("***retirar dinero***");
    	System.out.println(hora+":"+min+":"+seg);
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
