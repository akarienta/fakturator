package cz.akarienta.fakturator;

import cz.akarienta.fakturator.xml.XMLConstants;
import cz.akarienta.fakturator.xml.XMLReader;
import cz.akarienta.fakturator.xml.XMLWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.xpath.XPathExpressionException;
import org.javatuples.Pair;
import org.xml.sax.SAXException;

/**
 * Invoice data to render XML.
 *
 * @author akarienta
 */
public class InvoiceFactory {
    
    private Map<String, String> contractor = new TreeMap<String, String>();
    private Map<String, String> customer = new TreeMap<String, String>();
    private Map<String, String> details = new TreeMap<String, String>();
    private List<Pair<String, String>> items = new ArrayList<Pair<String, String>>();
    
    private XMLWriter invoiceWriter;
    private XMLReader contractorReader = new XMLReader(XMLConstants.CONTRACTOR_DATA);
    private XMLReader customerReader = new XMLReader(XMLConstants.CUSTOMERS_DATA);
    
    private File invoice;
    
    public InvoiceFactory(String customerName, Map<String, String> details, List<Pair<String, BigDecimal>> items) throws ParserConfigurationException, SAXException, XPathExpressionException, IOException {
        this.contractor = contractorReader.getContractor();
        
        // fix windows slashes
        String signaturePath = this.contractor.get(XMLConstants.CONTRACTOR_SIGNATURE_PATH);
        signaturePath = signaturePath.replace("\\", "/");
        this.contractor.put(XMLConstants.CONTRACTOR_SIGNATURE_PATH, signaturePath);
            
        this.customer = customerReader.getCustomer(customerName);
        this.details.putAll(details);
        
        BigDecimal totalSum = BigDecimal.ZERO;
        for (Pair<String, BigDecimal> item : items) {
            String name = item.getValue0();
            BigDecimal price = item.getValue1();
            
            totalSum = totalSum.add(price);
            this.items.add(new Pair(name, bigDecimalToCzechCrowns(price)));
        }
        
        this.details.put(XMLConstants.DETAILS_TOTAL_SUM, bigDecimalToCzechCrowns(totalSum));
        
        String invNum = String.format("%04d", Integer.parseInt(this.details.get(XMLConstants.DETAILS_INVOICE_NUMBER)));
        String year = Integer.toString(Calendar.getInstance().get(Calendar.YEAR));
        this.details.put(XMLConstants.DETAILS_INVOICE_NUMBER, year + "-" + invNum);
        
        File fileBase = new File(XMLConstants.USER_HOME, XMLConstants.APP_CONF_DIR);
        String invoiceFileName = String.format(XMLConstants.INVOICE_NAME, this.details.get(XMLConstants.DETAILS_INVOICE_NUMBER));
        
        this.invoice = new File(fileBase, invoiceFileName);
        this.invoice.createNewFile();
        this.invoiceWriter = new XMLWriter(invoiceFileName);
    }
    
    public String bigDecimalToCzechCrowns(BigDecimal price) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator(' ');
        symbols.setDecimalSeparator(',');
        DecimalFormat czechCrowns = new DecimalFormat("###,##0.00 Kč", symbols);
        String result = czechCrowns.format(price);
        return result;
    }
    
    public File renderInvoiceXml() throws ParserConfigurationException, TransformerException, TransformerConfigurationException, FileNotFoundException {
        invoiceWriter.createInvoice(this.contractor, this.customer, this.details, this.items);
        return this.invoice;
    }
    
    public String getInvoiceName() {
        return String.format(InvoiceCreator.INVOICE_FILENAME_BASE, this.details.get(XMLConstants.DETAILS_INVOICE_NUMBER));
    }
}
