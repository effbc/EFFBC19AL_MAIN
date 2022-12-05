enum 50074 OrderType
{
    Extensible = true;

    value(0; ItemOrder)
    {
        Caption = 'ItemOrder';
    }
    value(1; ProjectOrder)
    {
        Caption = 'ProjectOrder';
    }
}
enum 50075 NewStatus
{
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
        caption = 'Firm Planned';
    }
    value(3; Released)
    {
        Caption = 'Released';
    }
    value(4; Finished)
    {
        caption = 'Finished';
    }
}