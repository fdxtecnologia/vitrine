package com.mycompany.printerserverteste;

import java.awt.PrintJob;
import java.util.List;
import javax.swing.JFrame;
import javax.swing.JTabbedPane;
import org.cups4j.CupsClient;
import org.cups4j.CupsPrinter;
import java.io.File;
import java.io.FileInputStream;
import org.cups4j.PrintJob;

/**
 * Hello world!
 *
 */
public class App 
{
    private JTabbedPane mainTab = new JTabbedPane();
    private String hostname = "localhost";
    
    public static void main( String[] args )
    {
        new App((args.length > 0) ? args[0] : null);
    }
    
    public App(String host) {
        try {
          if (host != null)
           hostname = host;

          JFrame frame = new JFrame("Drucker auf " + hostname);
          frame.setSize(800, 600);
          frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
          frame.setContentPane(mainTab);
          
          FileInputStream file = new FileInputStream(new File(hostname));
          
          List<CupsPrinter> printers = new CupsClient().getPrinters();
          PrintJob job = new PrintJob.Builder(file).jobName("TESTE").userName(hostname).copies(1).build();
          
          printers.get(0).print(job);
          frame.setVisible(true);
        } catch (Exception e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
    }
    
//    private void addPrinterPanel(String name, IppResult result) {
//        mainTab.add(getPrinterPanel(result), name);
//    }
//    
//    private Container getPrinterPanel(IppResult result) {
//        JPanel jp = new JPanel();
//        jp.setLayout(new BorderLayout());
//        JTabbedPane tab = new JTabbedPane();
//
//        for (AttributeGroup group : result.getAttributeGroupList()) {
//          if (group.getAttribute().size() > 0) {
//            tab.add(getAttributeTab(group), group.getTagName());
//          }
//        }
//
//        jp.add(tab, BorderLayout.CENTER);
//        return jp;
//   }
//    
//  private Component getAttributeTab(AttributeGroup group) {
//    JPanel jp = new JPanel(new BorderLayout());
//    ScrollPane scp = new ScrollPane();
//    jp.add(scp, BorderLayout.CENTER);
//
//    FormLayout layout = new FormLayout("12dlu, pref, 6dlu, 30dlu:grow, 3dlu");
//    DefaultFormBuilder builder = new DefaultFormBuilder(layout);
//    builder.setLeadingColumnOffset(1);
//
//    Collections.sort(group.getAttribute(), new Comparator<Attribute>() {
//
//      @Override
//      public int compare(Attribute a1, Attribute a2) {
//        return a1.getName().compareTo(a2.getName());
//      }
//    });
//
//    for (Attribute att : group.getAttribute()) {
//      JComponent valueComponent = null;
//      if (att.getAttributeValue().size() > 0) {
//        JPanel panel = new JPanel(new BorderLayout());
//
//        AttributeValueTable table = new AttributeValueTable((getAttributeTableModel(att
//            .getAttributeValue())));
//        panel.add(table.getTableHeader(), BorderLayout.NORTH);
//        panel.add(table, BorderLayout.CENTER);
//        valueComponent = panel;
//
//      } else {
//        JLabel lb = new JLabel("no value reported");
//        lb.setForeground(Color.red);  
//        valueComponent = lb;
//      }
//      builder.appendSeparator();
//      builder.append(att.getName(), valueComponent);
//      builder.nextLine();
//    }
//    scp.add(builder.getPanel());
//
//    return jp;
//  }
//  
//  private DefaultTableModel getAttributeTableModel(List<AttributeValue> list) {
//    Vector<Vector<String>> data = new Vector<Vector<String>>();
//    Vector<String> names = new Vector<String>();
//    names.add("Tag Name");
//    names.add("Tag (Hex)");
//    names.add("Tag Value");
//    for (AttributeValue attrValue : list) {
//      data.add(getAttributeValue(attrValue));
//    }
//    return new DefaultTableModel(data, names);
//
//  }
// 
//  private Vector<String> getAttributeValue(AttributeValue attrValue) {
//    Vector<String> values = new Vector<String>();
//    values.add(attrValue.getTagName());
//    values.add(attrValue.getTag());
//    values.add(attrValue.getValue());
//
//    return values;
//  }
//
//  public class AttributeValueTable extends JTable {
//    private static final long serialVersionUID = -9079318497719930285L;
//
//    public AttributeValueTable(TableModel model) {
//      super(model);
//      TableColumnModel colmodel = getColumnModel();
//
//      // Set column widths
//      colmodel.getColumn(0).setPreferredWidth(100);
//      colmodel.getColumn(1).setPreferredWidth(30);
//      colmodel.getColumn(2).setPreferredWidth(150);
//    }
//  }

}
