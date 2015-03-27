/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cz.akarienta.fakturator.data;

/**
 * Customer data.
 * 
 * @author akarienta
 */
public enum Customer {
    NAME("name", "Jméno", true),    
    ADDRESS("address", "Ulice a číslo popisné/orientační", true),
    CITY("city", "Město", true),
    POSTAL_CODE("postalCode", "PSČ", true),
    ICO("ico", "IČ", true),
    DIC("dic", "DIČ", true);

    private final String nodeName;
    private final String label;
    private final boolean mandatory;
    
    private Customer(String nodeName, String formFieldName, boolean mandatory) {
        this.nodeName = nodeName;
        this.label = formFieldName;
        this.mandatory = mandatory;
    }
    
    public String getNodeName() {
        return this.nodeName;
    }
    
    public String getLabel() {
        return this.label;
    }
    
    public boolean isMandatory() {
        return this.mandatory;
    }
}
