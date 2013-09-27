package br.com.fdxtecnologia.consultapedido;

import br.com.fdxtecnologia.vitrine.services.wsdl.impl.Order;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.cups4j.CupsClient;
import org.cups4j.CupsPrinter;
import org.cups4j.PrintJob;

/**
 * Hello world!
 *
 */
public class App {

    public static void main(String[] args) {
        try { // Call Web Service Operation
            br.com.fdxtecnologia.vitrine.services.wsdl.impl.OrderWSDLService_Service service = new br.com.fdxtecnologia.vitrine.services.wsdl.impl.OrderWSDLService_Service();
            br.com.fdxtecnologia.vitrine.services.wsdl.impl.OrderWSDLService port = service.getOrderWSDLServicePort();
            // TODO process result here
            java.util.List<br.com.fdxtecnologia.vitrine.services.wsdl.impl.Order> result = port.getNonProcessedOrders();
            if (!result.isEmpty()) {
                int x = 0;
                for (Order o : result) {
                    List<Order> data = new ArrayList<Order>();
                    data.add(o);
                    JasperReport report = JasperCompileManager.compileReport("/Users/guilherme/Desktop/report/order.jrxml");
                    JasperPrint print = JasperFillManager.fillReport(report, null, new JRBeanCollectionDataSource(data));
                    JasperExportManager.exportReportToPdfFile(print, "/Users/guilherme/Desktop/report/order" + x + ".pdf");
                    FileInputStream file = new FileInputStream(new File("/Users/guilherme/Desktop/report/order" + x + ".pdf"));
                    List<CupsPrinter> printers = new CupsClient().getPrinters();
                    PrintJob job = new PrintJob.Builder(file).jobName("TESTE").userName("localhost").copies(1).build();
                    printers.get(0).print(job);
                    x++;
                }
            }
        } catch (Exception ex) {
            // TODO handle custom exceptions here

            ex.printStackTrace();
        }
    }
}
