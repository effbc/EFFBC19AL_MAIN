xmlport 80040 "TDS Accounting Period"
{
    Format = VariableText;

    schema
    {
        textelement(AccountingPeriods)
        {
            tableelement("<accountingperiod>"; "Accounting Period")
            {
                XmlName = 'AccountingPeriod';
                fieldelement(StartingDate; "<AccountingPeriod>"."Starting Date")
                {
                }
                fieldelement(Name; "<AccountingPeriod>".Name)
                {
                }
                fieldelement(NewFiscalYear; "<AccountingPeriod>"."New Fiscal Year")
                {
                }
                fieldelement(Closed; "<AccountingPeriod>".Closed)
                {
                }
                fieldelement(DateLocked; "<AccountingPeriod>"."Date Locked")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

