using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UsersC
/// </summary>
/// 
public class UserDetails
{
    public string Name { get; set; }
    public string SessionID { get; set; }
    public string MacAddress { get; set; }
    public UserDetails(string name, string session_id, string mac_address)
    {
        this.Name = name;
        this.SessionID = session_id;
        this.MacAddress = mac_address;
    }
}

public class UsersCollection
{
    public List<UserDetails> Items = new List<UserDetails>();
    public UsersCollection()
    {

    }

    public int Count
    {
        get
        {
            return Items.Count;
        }
    }

    public void Add(UserDetails user_dt)
    {
        Items.Add(user_dt);
    }

    public void Add(string name, string session_id, string mac_address)
    {
        var new_user = new UserDetails(name, session_id, mac_address);
        Add(new_user);
    }

    public void Remove(string session_id)
    {
        Items.RemoveAll(x => x.SessionID == session_id);
    }

    public bool CanLogin(string name, string session_id, string mac)
    {
        // logged in on same pc
        var test1 = Items.Where(x => x.Name == name && x.MacAddress == mac);
        if (test1.Any())
        {
            test1.First().SessionID = session_id;
            return true;
        }

        // logged in on different pc
        var test2 = Items.Where(x => x.Name == name);
        if (test2.Any())
        {
            return false;
        }

        Add(name, session_id, mac);
        return true;
    }
}