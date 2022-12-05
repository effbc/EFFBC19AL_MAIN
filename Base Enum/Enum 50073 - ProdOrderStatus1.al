enum 50073 ProdOrderStatus1
{
    Extensible = true;

    value(0; Quote)
    {
        Caption = 'Quote';
    }
    value(1; Planned)
    {
        Caption = 'Planned';
    }
    value(2; "Firm Planned")
    {
        Caption = 'Firm Planned';
    }
    value(3; Released)
    {
        Caption = 'Released';
    }
}