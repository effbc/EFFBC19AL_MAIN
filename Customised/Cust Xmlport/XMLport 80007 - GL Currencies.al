xmlport 80007 "G/L Currencies"
{
    Format = VariableText;

    schema
    {
        textelement(Currencies)
        {
            tableelement(Currency; Currency)
            {
                XmlName = 'Currency';
                fieldelement(Code; Currency.Code)
                {
                }
                fieldelement(UnrealizedGainsAcc; Currency."Unrealized Gains Acc.")
                {
                }
                fieldelement(RealizedGainsAcc; Currency."Realized Gains Acc.")
                {
                }
                fieldelement(UnrealizedLossesAcc; Currency."Unrealized Losses Acc.")
                {
                }
                fieldelement(RealizedLossesAcc; Currency."Realized Losses Acc.")
                {
                }
                fieldelement(InvoiceRoundingPrecision; Currency."Invoice Rounding Precision")
                {
                }
                fieldelement(InvoiceRoundingType; Currency."Invoice Rounding Type")
                {
                }
                fieldelement(AmountRoundingPrecision; Currency."Amount Rounding Precision")
                {
                }
                fieldelement(UnitAmountRoundingPrecision; Currency."Unit-Amount Rounding Precision")
                {
                }
                fieldelement(Description; Currency.Description)
                {
                }
                fieldelement(AmountDecimalPlaces; Currency."Amount Decimal Places")
                {
                }
                fieldelement(UnitAmountDecimalPlaces; Currency."Unit-Amount Decimal Places")
                {
                }
                fieldelement(RealizedGLGainsAccount; Currency."Realized G/L Gains Account")
                {
                }
                fieldelement(RealizedGLLossesAccount; Currency."Realized G/L Losses Account")
                {
                }
                fieldelement(ApplnRoundingPrecision; Currency."Appln. Rounding Precision")
                {
                }
                fieldelement(EMUCurrency; Currency."EMU Currency")
                {
                }
                fieldelement(CurrencyFactor; Currency."Currency Factor")
                {
                }
                fieldelement(ResidualGainsAccount; Currency."Residual Gains Account")
                {
                }
                fieldelement(ResidualLossesAccount; Currency."Residual Losses Account")
                {
                }
                fieldelement(ConvLCYRndgDebitAcc; Currency."Conv. LCY Rndg. Debit Acc.")
                {
                }
                fieldelement(ConvLCYRndgCreditAcc; Currency."Conv. LCY Rndg. Credit Acc.")
                {
                }
                //EFFUPG>>
                /*
                fieldelement(ExciseRoundingType; Currency."Excise Rounding Type")
                {
                }
                fieldelement(ExciseRoundingPrecision; Currency."Excise Rounding Precision")
                {
                }
                fieldelement(TDSRoundingType; Currency."TCS Rounding Type")
                {
                }
                fieldelement(TDSRoundingPrecision; Currency."TCS Rounding Precision")
                {
                }
                */
                //EFFUPG<<
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

