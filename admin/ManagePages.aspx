<%@ Page Title="Page Studio | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManagePages.aspx.cs" Inherits="admin_ManagePages" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
    <style>
        :root { --brand-primary: #6366f1; --brand-slate: #0f172a; }
        body { background-color: #f8fafc; }
        .studio-header { background: white; padding: 30px; border-radius: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); margin-bottom: 30px; border: 1px solid rgba(0,0,0,0.03); }
        .editor-container { background: white; border-radius: 40px; box-shadow: 0 20px 50px rgba(15, 23, 42, 0.05); overflow: hidden; border: 1px solid rgba(0,0,0,0.02); }
        
        /* Premium CKEditor Tweaks */
        .ck-editor__editable { min-height: 400px !important; border: none !important; font-size: 1.1rem; line-height: 1.8; padding: 40px !important; }
        .ck.ck-toolbar { background: #f8fafc !important; border: none !important; border-bottom: 1px solid #e2e8f0 !important; padding: 15px 30px !important; }

        .page-selector { 
            background: #f1f5f9; border: 2px solid transparent; border-radius: 15px; 
            padding: 10px 20px; font-weight: 700; color: var(--brand-slate); transition: 0.3s;
        }
        .btn-sync { 
            background: linear-gradient(135deg, var(--brand-primary), #4f46e5); color: white !important; 
            border: none; border-radius: 15px; padding: 12px 35px; font-weight: 800; text-transform: uppercase; transition: 0.4s;
        }
        .btn-sync:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(99, 102, 241, 0.3); }

        /* Preview Mode Unique Logic */
        #previewArea { display: none; padding: 40px; background: #fff; min-height: 400px; border-radius: 0 0 40px 40px; }
        .tab-btn { padding: 10px 25px; border-radius: 50px; font-weight: 800; cursor: pointer; transition: 0.3s; font-size: 0.8rem; }
        .tab-active { background: var(--brand-primary); color: white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="hfContent" runat="server" ClientIDMode="Static" />

    <div class="studio-header d-flex justify-content-between align-items-center animate__animated animate__fadeIn">
        <div>
            <h2 class="fw-900 text-slate-800 mb-1">Page Studio</h2>
            <p class="text-muted small fw-bold mb-0 uppercase tracking-widest"><i class="fas fa-circle text-success me-2 small animate-pulse"></i>Live Synchronizer</p>
        </div>
        <div class="d-flex align-items-center gap-3">
            <asp:DropDownList ID="ddlPages" runat="server" CssClass="page-selector shadow-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged">
                <asp:ListItem Value="about-us">About Us</asp:ListItem>
                <asp:ListItem Value="mission-vision">Mission & Vision</asp:ListItem>
                <asp:ListItem Value="disclaimer">Disclaimer</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnUpdate" runat="server" Text="Sync Website" CssClass="btn-sync shadow-lg" OnClientClick="return prepareSubmit();" OnClick="btnUpdate_Click" />
        </div>
    </div>

    <div class="editor-container animate__animated animate__fadeInUp">
        <div class="p-3 bg-light-subtle border-bottom d-flex gap-2">
            <div id="btnEdit" class="tab-btn tab-active" onclick="toggleMode('edit')"><i class="fas fa-code me-2"></i>Editor</div>
            <div id="btnPreview" class="tab-btn text-muted" onclick="toggleMode('preview')"><i class="fas fa-eye me-2"></i>Live Preview</div>
        </div>

        <div id="editorArea">
            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
        </div>
        
        <div id="previewArea" class="prose max-w-none">
            </div>
    </div>

    <script>
        let editorInstance;
        ClassicEditor.create(document.querySelector('#txtContent'), {
            toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', 'insertTable', 'undo', 'redo'],
            placeholder: 'Bhilwara ke students ke liye premium content likhein...'
        }).then(editor => { 
            editorInstance = editor; 
        }).catch(error => { console.error(error); });

        function toggleMode(mode) {
            const editorDiv = document.getElementById('editorArea');
            const previewDiv = document.getElementById('previewArea');
            const btnE = document.getElementById('btnEdit');
            const btnP = document.getElementById('btnPreview');

            if (mode === 'preview') {
                previewDiv.innerHTML = editorInstance.getData() || "<p class='text-muted'>Kuch likho toh sahi, Champion!</p>";
                editorDiv.style.display = 'none';
                previewDiv.style.display = 'block';
                btnP.classList.add('tab-active'); btnP.classList.remove('text-muted');
                btnE.classList.remove('tab-active'); btnE.classList.add('text-muted');
            } else {
                editorDiv.style.display = 'block';
                previewDiv.style.display = 'none';
                btnE.classList.add('tab-active'); btnE.classList.remove('text-muted');
                btnP.classList.remove('tab-active'); btnP.classList.add('text-muted');
            }
        }

        function prepareSubmit() {
            if (editorInstance) {
                document.getElementById('hfContent').value = editorInstance.getData();
            }
            return true;
        }
    </script>
</asp:Content>