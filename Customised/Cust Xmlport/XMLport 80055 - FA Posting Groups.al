xmlport 80055 "FA Posting Groups"
{
    Format = VariableText;

    schema
    {
        textelement(FAPostingGroups)
        {
            tableelement("<fapostinggroup>"; "FA Posting Group")
            {
                XmlName = 'FAPostingGroup';
                fieldelement(Code; "<FAPostingGroup>".Code)
                {
                }
                fieldelement(AcquisitionCostAccount; "<FAPostingGroup>"."Acquisition Cost Account")
                {
                }
                fieldelement(AccumDepreciationAccount; "<FAPostingGroup>"."Accum. Depreciation Account")
                {
                }
                fieldelement(AcqCostAcconDisposal; "<FAPostingGroup>"."Acq. Cost Acc. on Disposal")
                {
                }
                fieldelement(AccumDeprAcconDisposal; "<FAPostingGroup>"."Accum. Depr. Acc. on Disposal")
                {
                }
                fieldelement(GainsAcconDisposal; "<FAPostingGroup>"."Gains Acc. on Disposal")
                {
                }
                fieldelement(LossesAcconDisposal; "<FAPostingGroup>"."Losses Acc. on Disposal")
                {
                }
                fieldelement(MaintenanceExpenseAccount; "<FAPostingGroup>"."Maintenance Expense Account")
                {
                }
                fieldelement(DepreciationExpenseAcc; "<FAPostingGroup>"."Depreciation Expense Acc.")
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

