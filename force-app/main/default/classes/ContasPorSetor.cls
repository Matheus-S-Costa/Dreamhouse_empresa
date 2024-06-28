public class ContasPorSetor {
    public void MapAccountsByIndustry() {
        Map<String, Map<Id, List<Contact>>> mapIndustryForAccountsByContacts = new Map<String, Map<Id, List<Contact>>>();
        for (Contact c : [SELECT Id, Name, Email, MobilePhone, AccountId, Account.Name, Account.Industry FROM Contact WHERE AccountId != NULL ORDER BY Account.Industry]) {
            if (!mapIndustryForAccountsByContacts.containsKey(c.Account.Industry)) {
                mapIndustryForAccountsByContacts.put(c.Account.Industry, new Map<Id, List<Contact>>());
            }
            if (!mapIndustryForAccountsByContacts.get(c.Account.Industry).containsKey(c.AccountId)) {
                mapIndustryForAccountsByContacts.get(c.Account.Industry).put(c.AccountId, new List<Contact>());
            }
            mapIndustryForAccountsByContacts.get(c.Account.Industry).get(c.AccountId).add(c);
        }
        showList(mapIndustryForAccountsByContacts);
    }
    public void showList(Map<String, Map<Id, List<Contact>>> contactsByIndustryAndAccount) {
        Map<String, Map<Id, List<Contact>>> organizedByIndustry = new Map<String, Map<Id, List<Contact>>>();
        for (String industry : contactsByIndustryAndAccount.keySet()) {
            if (!organizedByIndustry.containsKey(industry)) {
                organizedByIndustry.put(industry, new Map<Id, List<Contact>>());
            }
            for (Id accountId : contactsByIndustryAndAccount.get(industry).keySet()) {
                if (!organizedByIndustry.get(industry).containsKey(accountId)) {
                    organizedByIndustry.get(industry).put(accountId, new List<Contact>());
                }
                organizedByIndustry.get(industry).get(accountId).addAll(contactsByIndustryAndAccount.get(industry).get(accountId));
            }
        }
        for (String industry : organizedByIndustry.keySet()) {
            System.debug(' ------- ' + ((industry == null) ? 'Setor não encontrado' : industry) + ' ------- ');
            for (Id accountId : organizedByIndustry.get(industry).keySet()) {
                System.debug('======= ' + organizedByIndustry.get(industry).get(accountId)[0].Account.Name + ' =======');
                displayContactDetails(organizedByIndustry.get(industry).get(accountId));
            }
        }
    }
    public void displayContactDetails(List<Contact> contacts) {
        for (Contact c : contacts) {
            System.debug((c.Name == null) ? 'Nome não encontrado!' : 'Nome: ' + c.Name);
            System.debug((c.Email == null) ? 'Email não encontrado!' : 'Email: ' + c.Email);
            System.debug((c.MobilePhone == null) ? 'Telefone não encontrado!' : 'Telefone: ' + c.MobilePhone);
            System.debug('----------------------------------');
        }
    }
}