enum 50337 PaymentMethod
{
    Extensible = true;

    value(0; Cash)
    {
        Caption = 'Cash';
    }
    value(1; Cheque)
    {
        Caption = 'Cheque';
    }
    value(2; "Bank Transfer")
    {
        Caption = 'Bank Transfer';
    }
}