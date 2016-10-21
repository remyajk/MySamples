<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<VckWebPortal.Models.VckModels>" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page - Value Card Kiosk
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
     <% if (!Request.IsAuthenticated) { %>
    <section class="featured">
            <hgroup class="title" style="text-align:center">
                <h2><%: ViewBag.Message %></h2>
            </hgroup>
        <div class="content-wrapper cardedge-border">
            <p>
                Beim Value Card Kiosk (VCK) handelt es ich um einen Verkaufsautomaten, welcher zur Ausgabe von individuell bedruckten Geschenkkarten entwickelt wurde und gleichzeitig unterschiedliche Artikel 24/7 verkauft. Mit diesem Zugang können Sie alle finanzrelevanten Administrationen abwickeln. Bitte loggen Sie sich mit Ihren Zugangsdaten ein.
            </p>
        </div>
    </section>
    <% } %>
    <% if (Request.IsAuthenticated) { %>
    <section class="featured">
        <div class="content-wrapper" id="status">
            <hgroup class="title">
                <h2><%: ViewBag.Message %></h2>
            </hgroup>
            <table style="width:100%">
                    <thead>
                  <tr>
                    <th><strong>Karten</strong></th>
                    <% foreach (var item in Model.HwDispenserTrays.OrderBy(x => x.trayname))
                          {%>
                      <th> <%: item.trayname %> </th>

                      <% } %>
                  </tr>
                  </thead>
                    <tbody>
                    <tr>
                      <td></td>
                    <% foreach (var item in Model.HwDispenserTrays.OrderBy(x => x.trayname))
                          {%>
                      <td> <%: item.number_of_cards %> </td>

                      <% } %>
                  </tr>
                        </tbody>
                </table>

            <table style="width:100%">
                <tr>
                    <th><strong>Umsätze</strong></th>
                    <td></td>
                    <td><strong>Bar:</strong> <%: (Model.VoucherCardLogs.Where(x => x.paymenttype == 2).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td></td>
                    <td></td>
                    <th><strong>Transaktionen</strong></th>
                    <td></td>
                    <td><strong>Bar:</strong> <%: Model.VoucherCardLogs.Count(x => x.paymenttype == 2) %></td>
                    <%--<th><strong>Gesamtwert Münzen: 12349</strong></th>
                    <th><strong>Gesamtwert Scheine: 12349</strong></th>--%>
                </tr> 
                <tr>
                    <th></th>
                    <td></td>
                    <td><strong>EFT Gesamt:</strong> <%: (Model.VoucherCardLogs.Where(x => x.paymenttype == 1).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td>EC: <%: (Model.VoucherCardLogs.Where(x => x.applicationname.StartsWith("ec", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <td></td>
                    <th></th>
                    <td></td>
                    <td><strong>EFT Gesamt:</strong> <%: Model.VoucherCardLogs.Count(x => x.paymenttype == 1) %></td>
                    <td>EC: <%: Model.VoucherCardLogs.Count(x =>  x.applicationname.StartsWith("ec", true, null)) %></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td>Maestro: <%: (Model.VoucherCardLogs.Where(x =>  x.applicationname.StartsWith("maestro", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Maestro: <%: Model.VoucherCardLogs.Count(x => x.applicationname.StartsWith("maestro", true, null)) %></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td>MasterCard: <%: (Model.VoucherCardLogs.Where(x => x.applicationname.StartsWith("mastercard", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>MasterCard: <%: Model.VoucherCardLogs.Count(x => x.applicationname.StartsWith("mastercard", true, null)) %></td>
                </tr>
                <tr>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td>Visa: <%: (Model.VoucherCardLogs.Where(x => x.applicationname.StartsWith("visa", true, null)).Sum(x => x.amount) / 100).ToString("0.00") + " " + Model.Currency %></td>
                    <th></th>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>Visa: <%: Model.VoucherCardLogs.Count(x => x.applicationname.StartsWith("visa", true, null)) %></td>
                </tr>
            </table>
        </div>
    </section>
    <% } %>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <% if (Request.IsAuthenticated) { %>
    <form runat="server">
        <div class="content-wrapper cardedge-border">

            <% if (User.IsInRole("Admin")) { %>
    <table style="width:100%" runat="server">
        <thead>
            <tr>
                <th style="width:25%">Fachbestände setzen</th>
                <td>
                    <%: Html.DropDownListFor(m => m.TrayId, (SelectList)ViewBag.tray_dd, "--- Alle Fächer ---") %>
                </td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>

                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtInhalt" Width="23%" Rows="1" ></asp:TextBox>
                    <%--
                    <%: Html.TextBoxFor(m => m.NumOfCards) %>
                        <input type="text" id="txtInhalt" runat="server" style="width:23%"/>--%>
                </td>
            </tr>
            <tr>
                <td>

                </td>
                <td>
                    <asp:Button runat="server" ID="btnInhaltSetzen2" Text="Inhalt setzen" OnClientClick="javascript:SetTrayScript();"/>
                </td>
            </tr>
        </tbody>
    </table>
            <% } %>

    <table style="width:100%">
        <thead>
            <tr>
                <th style="width:25%">Kassenschnitt</th>
                <td>
                    <asp:Button runat="server" ID="btnXAbschlag" Text="X-Abschlag generieren" OnClientClick="javascript:OpenXAbschlagContent();"/>
                </td>

                <% if (User.IsInRole("Admin")) { %>
                <td>
                    <asp:Button runat="server" ID="btnZAbschlag" Text="Z-Abschlag generieren" OnClientClick="javascript:OpenZAbschlagContent();"/>
                </td>
                <% } %>
            </tr>
        </thead>
    </table>

    <table style="width:100%" runat="server">
        <thead>
            <tr>
                <th style="width:25%">Transaktionssuche</th>
                <td>Datum</td>
                <td>Uhrzeit</td>
                <td>Letzte 4 Stellen Kredit- / Bankkartennummer</td>
                <td>Transaktionsnummer</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    
                </td>
                <td>
                    <asp:Textbox runat="server" ID="txtDate" Width="100%" MaxLength="10" Rows="1"></asp:Textbox>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtTime" Width="100%" MaxLength="5" Rows="1"></asp:TextBox>
                </td>
                <td>
                    <asp:Label runat="server" ID="lbl4Kartenstellen" Text="XXXX XXXX XXXX -" Width="70%"></asp:Label>
                    <asp:TextBox runat="server" ID="txt4Kartenstellen" Width="20%" MaxLength="4" Rows="1"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtTransaktionsnummer" Width="100%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>

                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkDate" ></asp:CheckBox> <asp:Label runat="server" >Filter</asp:Label>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkTime"></asp:CheckBox> <asp:Label runat="server" >Filter</asp:Label>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chk4Kartenstellen"></asp:CheckBox> <asp:Label runat="server" >Filter</asp:Label>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkTransaktionsnummer" ></asp:CheckBox> <asp:Label runat="server">Filter</asp:Label>
                </td>
            </tr>
            <tr>
                <td>

                </td>
                <td>
                    <asp:Button runat="server" ID="btnTransSuche" Text="Suchen" Width="110%" OnClientClick="javascript:OpenTransaktionssucheContent(); return false;"/>
                </td>
            </tr>
        </tbody>
    </table>

    <table style="width:100%" runat="server">
        <thead>
            <tr>
                <th style="width:25%">Statistiken</th>
                <td>Datum von</td>
                <td>Datum bis</td>
                <td style="width:20%"></td>
                <td style="width:20%"></td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    
                </td>
                <td>
                    <asp:Textbox runat="server" ID="txtStatistikDateVon" MaxLength="10" Width="83px" Rows="1"></asp:Textbox> 
                </td>
                <td>
                    <asp:Textbox runat="server" ID="txtStatistikDateBis" MaxLength="10" Width="83px" Rows="1"></asp:Textbox>
                </td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    
                </td>
                <td>
                    <asp:Button runat="server" ID="btnStatistikTag" Text="Statistik anzeigen" OnClientClick="javascript:OpenTagesstatistikContent(); return false;"/> 
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkStatistikDetails" ></asp:CheckBox> <asp:Label runat="server" >inkl. Details</asp:Label>
                </td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>

            </div>
</form>
     <% } %>
</asp:Content>

<asp:Content ID="scripts" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        function OpenTagesstatistikContent() {
            if (checkIfDate(document.getElementById('<%=txtStatistikDateVon.ClientID%>').value) && checkIfDate(document.getElementById('<%=txtStatistikDateBis.ClientID%>').value)) {

                var parts = document.getElementById('<%=txtStatistikDateVon.ClientID%>').value.split(".");

                var d1 = new Date(parts[2], parts[1] - 1, parts[0]);

                parts = document.getElementById('<%=txtStatistikDateBis.ClientID%>').value.split(".");

                var d2 = new Date(parts[2], parts[1] - 1, parts[0]);

                if (d1.getTime() > d2.getTime()) {
                    alert("Input fehlerhaft: 'Datum bis' liegt vor 'Datum von'.");
                    return;
                }
                window.open("/Vck/Tagesstatistik?sDateVon=" + document.getElementById('<%=txtStatistikDateVon.ClientID%>').value + "&sDateBis=" + document.getElementById('<%=txtStatistikDateBis.ClientID%>').value
                    + "&bDetails=" + document.getElementById('<%=chkStatistikDetails.ClientID%>').checked, "popupWindow", "height=800,addressbar=no,menubar=no,scrollbars=yes");
            }
            else {
                alert("Input fehlerhaft: Kein Datumsformat (TT.MM.JJJJ).");
            }
        }
    </script>
    <script type="text/javascript">
        function OpenTransaktionssucheContent() {
            if ((checkIfDate(document.getElementById('<%=txtDate.ClientID%>').value) || !document.getElementById('<%=chkDate.ClientID%>').checked)
                && (checkIfTime(document.getElementById('<%=txtTime.ClientID%>').value) || !document.getElementById('<%=chkTime.ClientID%>').checked)
                && (checkIf4Digits(document.getElementById('<%=txt4Kartenstellen.ClientID%>').value) || !document.getElementById('<%=chk4Kartenstellen.ClientID%>').checked)) {
                window.open("/Vck/Transaktionssuche?sdate=" + document.getElementById('<%=txtDate.ClientID%>').value + "&bdate=" + document.getElementById('<%=chkDate.ClientID%>').checked
                    + "&stime=" + document.getElementById('<%=txtTime.ClientID%>').value + "&btime=" + document.getElementById('<%=chkTime.ClientID%>').checked
                    + "&sccnumber=" + document.getElementById('<%=txt4Kartenstellen.ClientID%>').value + "&bccnumber=" + document.getElementById('<%=chk4Kartenstellen.ClientID%>').checked
                    + "&stransnumber=" + document.getElementById('<%=txtTransaktionsnummer.ClientID%>').value + "&btransnumber=" + document.getElementById('<%=chkTransaktionsnummer.ClientID%>').checked, "popupWindow", "height=800,addressbar=no,menubar=no,scrollbars=yes");
            }
            else {
                alert("Einschränkungen fehlerhaft. Kontrollieren Sie Datums- (TT.MM.JJJJ), Uhrzeit- (HH:MM) und / oder Kartennummernformat (dddd).");
            }
        }
    </script>
    <script type="text/javascript">
        function OpenXAbschlagContent() {
            window.open("/Vck/XAbschlag/", "popupWindow", "width=900,height=600,addressbar=no,menubar=no");
        }
    </script>
    <script type="text/javascript">
        function OpenZAbschlagContent() {
            window.open("/Vck/ZAbschlag/", "popupWindow", "width=900,height=600,addressbar=no,menubar=no");
        }
    </script>
    <script type="text/javascript">
        function OpenTraymanagerContent() {
            if (checkIfNumeric(document.getElementById('<%=txtInhalt.ClientID%>').value) && document.getElementById('<%=txtInhalt.ClientID%>').value <= 250) {
                <%--web_window = window.open("/Vck/Traymanager?trayID=" + document.getElementById('<%=ddStackerWahl.ClientID%>').value + "&numOfCards=" + document.getElementById('<%=txtInhalt.ClientID%>').value,
                    + "popupWindow", "width=1,height=1,addressbar=no,menubar=no,scrollbars=yes");--%>
                //web_window =
                    window.open("/Vck/Traymanager?trayID=" + document.getElementById('TrayId').value + "&numOfCards=" + document.getElementById('<%=txtInhalt.ClientID%>').value,
                    + "popupWindow", "width=1,height=1,addressbar=no,menubar=no").close();
                //web_window.close();
                //refreshDiv();
            }
            else {
                alert("Fachbestand-Input fehlerhaft. Nur Zahlen zulässig. \nMinimum: 0 Maximum: 255");
            }
        }
    </script>
    <script type="text/javascript">
        function SetTrayScript() {
            if (checkIfNumeric(document.getElementById('<%=txtInhalt.ClientID%>').value) && document.getElementById('<%=txtInhalt.ClientID%>').value <= 250) {
                //location.href = '<s%: Url.Action("SetTrays","Vck", new { trayID = tray, numOfCards = numCards}) %>';
                location.href = "/Vck/SetTrays?trayID=" + document.getElementById('TrayId').value + "&numOfCards=" + document.getElementById('<%=txtInhalt.ClientID%>').value;
            }
            else {
                alert("Fachbestand-Input fehlerhaft. Nur Zahlen zulässig. \nMinimum: 0 Maximum: 255");
            }
        }
    </script>
    <script type="text/javascript">
        function refreshDiv() {

            $.ajax({
                url: "Index.aspx",

                type: "GET",
                dataType: "html",
                success: function (data) {
                    var result = $('<div />').append(data).find('#status').html();
                    $('#status').html(result);
                },
                error: function (xhr, status) {
                    alert("Sorry, there was a problem!");
                },
                complete: function (xhr, status) {
                    //$('#showresults').slideDown('slow')
                }
            });

        }
    </script>
    <script type="text/javascript">
        function checkIfDate(inputstring) {
            var reg = /^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/;
            return reg.test(inputstring);
        }
    </script>
    <script type="text/javascript">
        function checkIfTime(inputstring) {
            var reg = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/;
            return reg.test(inputstring);
        }
    </script>
    <script type="text/javascript">
        function checkIf4Digits(inputstring) {
            var reg = /^[0-9]{4}$/;
            return reg.test(inputstring);
        }
    </script>
    <script type="text/javascript">
        function checkIfNumeric(inputstring) {
            var reg = /^[0-9]*$/;
            return reg.test(inputstring);
        }
    </script>
</asp:Content>
