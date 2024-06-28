public class ContactsByAccount {
    public void mapMethod() {
        Map<Id, List<Contact>> contactsAndAccounts = new Map<Id, List<Contact>>();
        for (Contact c : [SELECT Id, Name, MobilePhone, Email, AccountId, Account.Name FROM Contact WHERE AccountId != NULL ORDER BY Account.Name]) {
            if (!contactsAndAccounts.containsKey(c.AccountId)) {
                contactsAndAccounts.put(c.AccountId, new List<Contact>());
            }
            contactsAndAccounts.get(c.AccountId).add(c);
        }
        showList(contactsAndAccounts);
    }
    private void showList(Map<Id, List<Contact>> contactsAndAccounts){
        for (Id accountId : contactsAndAccounts.keySet()){
            String accName = null;
            Boolean isFirstContact = true;

            for(Contact c : contactsAndAccounts.get(accountId)){
                if(isFirstContact){
                    accName = c.Account.Name;
                    System.debug(' ======= '  + accName + ' ======= ');
                    System.debug(' Contatos: ');
                    isFirstContact = false;
                }
                displayContactDetails(c);
            } 
        }
    }
    private void displayContactDetails(Contact c) {
        System.debug((c.Name == null) ? ' Nome não encontrado! ' : 'Nome: ' + c.Name);
        System.debug((c.Email == null) ? 'Email não encontrado! ': 'Email: ' + c.Email);
        System.debug((c.MobilePhone == null) ? ' Telefone não encontrado! ' : 'Telefone: ' + c.MobilePhone);
        System.debug(' ---------------------------------- ');
    }
}