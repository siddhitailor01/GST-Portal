<%@ Page Title="Course Builder | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManageLessons.aspx.cs" Inherits="admin_ManageLessons" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
    <style>
        :root { --brand-primary: #6366f1; --brand-secondary: #a855f7; }
        
        /* Premium Editor Box */
        .editor-wrapper { background: white; border-radius: 35px; box-shadow: 0 20px 50px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid rgba(0,0,0,0.02); }
        .editor-header { background: #0f172a; color: white; padding: 30px 40px; }
        
        /* CKEditor Custom Styling */
        .ck-editor__editable { min-height: 450px !important; border-bottom-left-radius: 25px !important; border-bottom-right-radius: 25px !important; font-size: 1.1rem; line-height: 1.8; padding: 35px !important; color: #334155; }
        .ck.ck-toolbar { border: none !important; background: #f8fafc !important; padding: 15px 30px !important; border-bottom: 1px solid #e2e8f0 !important; }

        /* Form Elements */
        .luxury-input { background: #f1f5f9; border: 2px solid transparent; border-radius: 15px; padding: 12px 20px; font-weight: 600; transition: 0.3s; }
        .luxury-input:focus { background: white; border-color: var(--brand-primary); outline: none; box-shadow: 0 10px 20px rgba(99,102,241,0.1); }
        
        .level-badge { font-size: 0.65rem; font-weight: 800; text-transform: uppercase; padding: 5px 12px; border-radius: 50px; letter-spacing: 1px; }
        .level-1 { background: #dcfce7; color: #16a34a; }
        .level-2 { background: #e0f2fe; color: #0369a1; }
        .level-3 { background: #fef2f2; color: #991b1b; }

        .btn-save-content { background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary)); color: white !important; border: none; border-radius: 15px; padding: 15px 40px; font-weight: 900; text-transform: uppercase; transition: 0.4s; letter-spacing: 1px; }
        .btn-save-content:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(168, 85, 247, 0.3); }

        .grid-card { border-radius: 35px; background: white; box-shadow: 0 10px 30px rgba(0,0,0,0.02); overflow: hidden; border: 1px solid #f1f5f9; }
        .gv-lessons th { background: #f8fafc; color: #64748b; text-transform: uppercase; font-size: 0.7rem; letter-spacing: 1.5px; padding: 25px 20px; border: none !important; }
        .gv-lessons td { padding: 25px 20px; vertical-align: middle; border-bottom: 1px solid #f8fafc !important; }
        
        /* Unique Logic: Word Count Badge */
        #wordCountBadge { background: #0f172a; color: #94a3b8; padding: 5px 15px; border-radius: 10px; font-size: 0.7rem; font-weight: 800; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row align-items-center mb-5 animate__animated animate__fadeIn">
        <div class="col-md-8">
            <h2 class="fw-900 text-slate-800 mb-1">Curriculum Architect</h2>
            <p class="text-muted fw-600 mb-0">Designing the learning path for Rajasthan's GST Champions.</p>
        </div>
     <div class="col-md-4 text-end">
    <div class="badge bg-white text-dark shadow-sm border px-3 py-2 rounded-pill fw-bold me-2">
        <i class="fas fa-book-bookmark text-success me-2"></i>
        LESSONS: <asp:Literal ID="litCount" runat="server"></asp:Literal>
    </div>

   
</div>
    </div>

    <asp:HiddenField ID="hfLessonID" runat="server" />

    <div class="editor-wrapper mb-5 animate__animated animate__fadeInUp">
        <div class="editor-header d-flex justify-content-between align-items-center">
            <h5 class="fw-800 mb-0"><i class="fas fa-wand-magic-sparkles me-2 text-indigo-400"></i>Article Composer</h5>
            <div class="small opacity-50 uppercase fw-bold tracking-widest">Premium Editor Active</div>
        </div>
        
        <div class="p-5">
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <label class="small fw-800 text-muted uppercase d-block mb-2">Skill Tier</label>
                    <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select luxury-input w-100" AutoPostBack="true" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged">
                        <asp:ListItem Value="1">Level 1 (Foundations)</asp:ListItem>
                        <asp:ListItem Value="2">Level 2 (Practical)</asp:ListItem>
                        <asp:ListItem Value="3">Level 3 (Expert)</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="small fw-800 text-muted uppercase d-block mb-2">Topic Category</label>
                    <asp:DropDownList ID="ddlTopic" runat="server" CssClass="form-select luxury-input w-100"></asp:DropDownList>
                </div>
                <div class="col-md-5">
                    <label class="small fw-800 text-muted uppercase d-block mb-2">Lesson Heading</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="luxury-input w-100" placeholder="e.g. Masterclass on Input Tax Credit"></asp:TextBox>
                </div>
            </div>

            <div class="mb-5">
                <label class="small fw-800 text-muted uppercase d-block mb-2">Course Narrative</label>
                <div class="shadow-sm rounded-4 overflow-hidden border">
                    <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>

            <div class="d-flex justify-content-between align-items-center">
                <div class="text-muted small fw-bold"><i class="fas fa-shield-check me-1 text-success"></i> Autosave ready</div>
                <asp:Button ID="btnSaveLesson" runat="server" Text="Commit to Database" CssClass="btn-save-content px-5" OnClick="btnSaveLesson_Click" />
            </div>
        </div>
    </div>

    <div class="grid-card animate__animated animate__fadeInUp">
        <div class="p-4 border-bottom bg-light-subtle d-flex justify-content-between align-items-center">
            <h6 class="fw-900 mb-0 uppercase small text-dark tracking-widest">Published Curriculum</h6>
            <div class="badge bg-white text-primary border px-3 py-2 rounded-pill fw-bold shadow-sm">Verified Accuracy</div>
        </div>
        
        <div class="table-responsive">
            <asp:GridView ID="gvLessons" runat="server" AutoGenerateColumns="False" 
                CssClass="table gv-lessons mb-0" DataKeyNames="LessonID" 
                OnRowDeleting="gvLessons_RowDeleting" OnRowCommand="gvLessons_RowCommand">
                <Columns>
                  <asp:TemplateField HeaderText="Lesson Identity">
    <ItemTemplate>
        <div class="fw-800 text-slate-700 fs-6 mb-1"><%# Eval("LessonTitle") %></div>
        <div class="d-flex align-items-center gap-3">
            <div class="small text-muted fw-700 uppercase" style="font-size: 0.65rem;">
                <i class="fas fa-layer-group me-1 text-primary opacity-50"></i><%# Eval("TopicName") %>
            </div>
            <span class="badge bg-light text-dark border small" style="font-size: 0.6rem;">
                <i class="far fa-clock me-1"></i> 
                <%# (Eval("LessonContent").ToString().Length / 200) + 1 %> min read
            </span>
        </div>
    </ItemTemplate>
</asp:TemplateField>

                    <asp:TemplateField HeaderText="Tier">
                        <ItemTemplate>
                            <span class='level-badge level-<%# Eval("LevelNo") %>'>Level <%# Eval("LevelNo") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="220" ItemStyle-CssClass="text-end pe-4">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditLesson" 
                                CommandArgument='<%# Eval("LessonID") %>' CssClass="btn btn-sm btn-white border rounded-pill px-4 fw-bold me-2 shadow-sm">
                                <i class="fas fa-edit text-primary me-1"></i> Edit
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                CssClass="btn btn-sm btn-white border rounded-circle shadow-sm" OnClientClick="return confirm('Bhai, pakka delete karna hai?');">
                                <i class="fas fa-trash-alt text-danger"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <script>
        let editor;
        ClassicEditor
            .create(document.querySelector('#<%= txtContent.ClientID %>'), {
                toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', 'insertTable', 'undo', 'redo'],
                placeholder: 'Start writing your GST expertise here...'
            })
            .then(newEditor => {
                editor = newEditor;
                
        // Unique Logic: Real-time Word Counter
        editor.model.document.on('change:data', () => {
            const data = editor.getData().replace(/<[^>]*>/g, '');
                    const words = data.trim().split(/\s+/).filter(w => w.length > 0).length;
        document.querySelector('#count').innerText = words;
        });
        })
            .catch(error => { console.error(error); });
    </script>
</asp:Content>