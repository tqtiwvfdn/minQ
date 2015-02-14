<%
    if request("topicTitle")<>"" then
        set conn=Server.CreateObject("ADODB.Connection")
	    		conn.Provider="Microsoft.Jet.OLEDB.4.0"
	    		conn.Open(Server.Mappath("data/minQ.mdb"))
        set rs=Server.CreateObject("ADODB.recordset")
        dim sql,newID
            sql="SELECT top 1 * from topic"
        rs.Open sql,conn,1,3
        rs.AddNew
            rs("writerName")=request("writerName")
            rs("writerIsMan")=request("writerIsMan")
            rs("writerArea")=request("writerArea")
            rs("topicTitle")=request("topicTitle")
        rs.Update
        
        on error resume next
        if err<>0 then
            response.Write("{""writerID"":""-1""}")
        else
            response.Write("{""writerID"":""" & rs("writerID") & """}")
        end if
        'sql="INSERT INTO topic(writerName,writerIsMan,writerArea,topicTitle) VALUES('"
        'sql=sql & replace(request("writerName"),"'","''") & "','"
        'sql=sql & replace(request("writerIsMan"),"'","''") & "','"
        'sql=sql & replace(request("writerArea"),"'","''") & "','"
        'sql=sql & replace(request("topicTitle"),"'","''") & "');"
        '
        'response.Write(sql)

        rs.Close
        conn.Close
    set conn=nothing
    end if
%>