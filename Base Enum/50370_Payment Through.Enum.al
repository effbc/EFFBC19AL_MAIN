enum 50370 "Payment Through"
{
    Extensible = true;

    value(0; " ")
    {
    }
    value(1; Cheque)
    {
        Caption = 'Cheque';
    }
    value(2; Cash)
    {
        Caption = 'Cash';
    }
    value(3; DD)
    {
        Caption = 'DD';
    }
    value(4; FDR)
    {
        Caption = 'FDR';
    }
    value(5; RTGS)
    {
        Caption = 'RTGS';
    }
    value(6; FTT)
    {
        Caption = 'FTT';
    }
    value(7; "Credit-Card")
    {

    }
}