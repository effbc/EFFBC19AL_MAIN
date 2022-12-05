xmlport 80503 Role
{
    Format = VariableText;

    schema
    {
        textelement(Permissions)
        {
            tableelement(Permission; Permission)
            {
                XmlName = 'Permission';
                fieldelement(RoleID; Permission."Role ID")
                {
                }
                fieldelement(RoleName; Permission."Role Name")
                {
                }
                fieldelement(ObjectType; Permission."Object Type")
                {
                }
                fieldelement(ObjectID; Permission."Object ID")
                {
                }
                fieldelement(ObjectName; Permission."Object Name")
                {
                }
                fieldelement(ReadPermission; Permission."Read Permission")
                {
                }
                fieldelement(InsertPermission; Permission."Insert Permission")
                {
                }
                fieldelement(ModifyPermission; Permission."Modify Permission")
                {
                }
                fieldelement(DeletPermission; Permission."Delete Permission")
                {
                }
                fieldelement(ExecutePermission; Permission."Execute Permission")
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

