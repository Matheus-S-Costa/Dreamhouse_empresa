public class OrdemPorConta{
    public void CaseByAccount(){
        Map<Id, List<Cases>> CaseByAccount = new Map<Id, List<Case>>();
        for (Case case : [SELECT Id, name from Account where Account.Id!= NULL LIMIT 10]);
    }

} 