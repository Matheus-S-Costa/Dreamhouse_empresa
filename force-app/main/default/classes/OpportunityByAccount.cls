public class OpportunityByAccount {
    public void mapOpportunitiesByAccount() {
        Map<String, Map<Id, List<Opportunity>>> mapIndustryForOpportunitiesByAccount = new Map<String, Map<Id, List<Opportunity>>>();
        for (Opportunity opp : [SELECT Id, Name, CloseDate, StageName, AccountId, Account.Name, Account.Industry FROM Opportunity WHERE AccountId != NULL ORDER BY Account.Industry]) {
            if (!mapIndustryForOpportunitiesByAccount.containsKey(opp.Account.Industry)) {
                mapIndustryForOpportunitiesByAccount.put(opp.Account.Industry, new Map<Id, List<Opportunity>>());
            }
            if (!mapIndustryForOpportunitiesByAccount.get(opp.Account.Industry).containsKey(opp.AccountId)) {
                mapIndustryForOpportunitiesByAccount.get(opp.Account.Industry).put(opp.AccountId, new List<Opportunity>());
            }
            mapIndustryForOpportunitiesByAccount.get(opp.Account.Industry).get(opp.AccountId).add(opp);
        }
        showOpportunitiesList(mapIndustryForOpportunitiesByAccount);
    }

    public void showOpportunitiesList(Map<String, Map<Id, List<Opportunity>>> opportunitiesByIndustryAndAccount) {
        Map<String, Map<Id, List<Opportunity>>> organizedByIndustry = new Map<String, Map<Id, List<Opportunity>>>();
        for (String industry : opportunitiesByIndustryAndAccount.keySet()) {
            if (!organizedByIndustry.containsKey(industry)) {
                organizedByIndustry.put(industry, new Map<Id, List<Opportunity>>());
            }
            for (Id accountId : opportunitiesByIndustryAndAccount.get(industry).keySet()) {
                if (!organizedByIndustry.get(industry).containsKey(accountId)) {
                    organizedByIndustry.get(industry).put(accountId, new List<Opportunity>());
                }
                organizedByIndustry.get(industry).get(accountId).addAll(opportunitiesByIndustryAndAccount.get(industry).get(accountId));
            }
        }
        for (String industry : organizedByIndustry.keySet()) {
            System.debug(' ------- ' + ((industry == null) ? 'Setor não encontrado' : industry) + ' ------- ');
            for (Id accountId : organizedByIndustry.get(industry).keySet()) {
                System.debug('======= ' + organizedByIndustry.get(industry).get(accountId)[0].Account.Name + ' =======');
                displayOpportunityDetails(organizedByIndustry.get(industry).get(accountId));
            }
        }
    }

    public void displayOpportunityDetails(List<Opportunity> opportunities) {
        for (Opportunity opp : opportunities) {
            System.debug((opp.Name == null) ? 'Nome não encontrado!' : 'Nome: ' + opp.Name);
            System.debug((opp.CloseDate == null) ? 'Data de Fechamento não encontrada!' : 'Data de Fechamento: ' + opp.CloseDate);
            System.debug((opp.StageName == null) ? 'Status não encontrado!' : 'Status: ' + opp.StageName);
            System.debug('----------------------------------');
        }
    }
}