<%
        set conn=Server.CreateObject("ADODB.Connection")
	    		conn.Provider="Microsoft.Jet.OLEDB.4.0"
	    		conn.Open(Server.Mappath("data/minQ.mdb"))
        set rs=Server.CreateObject("ADODB.recordset")
        dim sql
            sql="SELECT * from topic"

        if request("writerID")<>"" then
            sql=sql & " where writerID=" & request("writerID")
        end if
            sql=sql & ";"

        rs.Open sql,conn
        
        dim writers
            writers="[{"
                do until rs.EOF
                    for each x in rs.Fields
                        writers=writers & "'" & x.Name & "':'" & x.Value & "',"
                    next
                        writers=writers &"},{"
                    rs.MoveNext
                loop
            writers=writers & "}]"
        rs.Close
        conn.Close
    set conn=nothing

    response.Write(writers)
%>