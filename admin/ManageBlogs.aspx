<%@ Page Title="Knowledge Engine | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManageBlogs.aspx.cs" Inherits="admin_ManageBlogs" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --brand-success: #10b981; --brand-primary: #6366f1; --surface-color: #ffffff; }
        
        .page-header { background: white; padding: 30px; border-radius: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); margin-bottom: 30px; border: 1px solid rgba(0,0,0,0.03); }
        
        .editor-card { background: white; border-radius: 30px; border: none; box-shadow: 0 20px 50px rgba(15, 23, 42, 0.05); overflow: hidden; position: sticky; top: 100px; }
        .editor-header { background: #0f172a; color: white; padding: 25px; }

        /* Luxury Inputs */
        .luxury-input { 
            background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 15px; 
            padding: 15px 20px; font-weight: 600; transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .luxury-input:focus { 
            background: white; border-color: var(--brand-primary); 
            box-shadow: 0 0 0 5px rgba(99, 102, 241, 0.1); outline: none; 
        }

        /* Modern Image Upload Placeholder */
        .upload-zone {
            width: 100%; height: 160px; border: 2px dashed #cbd5e1; border-radius: 20px;
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            background: #f1f5f9; cursor: pointer; transition: 0.3s; position: relative;
        }
        .upload-zone:hover { border-color: var(--brand-primary); background: #f5f3ff; }
        #imgPreview { width: 100%; height: 100%; object-fit: cover; border-radius: 18px; display: none; position: absolute; top: 0; left: 0; }

        /* Grid Styling */
        .blog-grid { border-radius: 30px; background: white; box-shadow: 0 10px 30px rgba(0,0,0,0.03); overflow: hidden; border: 1px solid #f1f5f9; }
        .grid-view-custom th { background: #f8fafc; color: #475569; padding: 20px; font-weight: 800; text-transform: uppercase; font-size: 0.7rem; letter-spacing: 1.5px; border: none !important; }
        .grid-view-custom td { padding: 25px 20px; vertical-align: middle; border-bottom: 1px solid #f1f5f9 !important; }

        .btn-glow-success { 
            background: linear-gradient(135deg, #10b981, #059669); color: white !important; 
            border: none; border-radius: 15px; padding: 15px; font-weight: 800; 
            text-transform: uppercase; letter-spacing: 1px; transition: 0.4s;
        }
        .btn-glow-success:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(16, 185, 129, 0.3); }
        
        .search-wrapper { background: #f1f5f9; border-radius: 50px; padding: 5px 5px 5px 25px; display: flex; align-items: center; border: 1px solid #e2e8f0; }
        .search-input { border: none; background: transparent; font-weight: 600; color: #1e293b; outline: none; width: 250px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
    <div class="page-header d-flex justify-content-between align-items-center">
        <div>
            <h2 class="fw-900 mb-1 text-slate-800">Content Hub</h2>
            <p class="text-muted mb-0 small uppercase fw-bold tracking-widest">Publishing GST Excellence for Bhilwara</p>
        </div>
        <div class="search-wrapper shadow-sm">
            <i class="fas fa-search text-muted me-2"></i>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search articles..."></asp:TextBox>
            <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-dark rounded-pill px-4 fw-bold">Find</asp:LinkButton>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-4">
            <div class="editor-card shadow-lg">
                <div class="editor-header">
                    <h5 class="fw-800 mb-0"><i class="fas fa-feather-pointed me-2"></i>New Draft</h5>
                </div>
                <div class="p-4">
                    <label class="form-label small fw-800 text-muted uppercase">Cover Image</label>
                    <div class="upload-zone mb-4" onclick="document.getElementById('<%= fuImage.ClientID %>').click()">
                        <img id="imgPreview" src="#" alt="Preview" />
                        <i class="fas fa-image fa-2x text-muted mb-2"></i>
                        <span class="small fw-bold text-muted">Click to Upload</span>
                        <asp:FileUpload ID="fuImage" runat="server" style="display:none" onchange="showPreview(this)" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-800 text-muted">Article Heading</label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="luxury-input w-100" placeholder="Enter title..."></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-800 text-muted">Short Snippet</label>
                        <asp:TextBox ID="txtShortDesc" runat="server" CssClass="luxury-input w-100" TextMode="MultiLine" Rows="2" placeholder="Summarize the article..."></asp:TextBox>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-800 text-muted">Full Content</label>
                        <asp:TextBox ID="txtContent" runat="server" CssClass="luxury-input w-100" TextMode="MultiLine" Rows="6" placeholder="Write your content here..."></asp:TextBox>
                    </div>

                    <asp:Button ID="btnSaveBlog" runat="server" Text="Publish Article" CssClass="btn-glow-success w-100" OnClick="btnSaveBlog_Click" />
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="blog-grid">
                <div class="p-4 border-bottom bg-light-subtle d-flex justify-content-between align-items-center">
                    <h6 class="fw-900 mb-0 text-dark uppercase small">Live Publications</h6>
                    <div class="badge bg-primary-subtle text-primary rounded-pill px-3 py-2 fw-bold">Count: <asp:Literal ID="litTotal" runat="server"></asp:Literal></div>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvBlogs" runat="server" AutoGenerateColumns="False" 
                        CssClass="table grid-view-custom mb-0" DataKeyNames="BlogID" 
                        OnRowDeleting="gvBlogs_RowDeleting" OnRowEditing="gvBlogs_RowEditing" 
                        OnRowUpdating="gvBlogs_RowUpdating" OnRowCancelingEdit="gvBlogs_RowCancelingEdit">
                        <Columns>
                            <asp:TemplateField HeaderText="Article Meta">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center">
                                        <div class="position-relative">
                                            <asp:Image ID="imgBlog" runat="server" 
                                                ImageUrl='<%# string.IsNullOrEmpty(Eval("ImagePath").ToString()) ? "../assets/img/placeholder.jpg" : "uploads/blogs/" + Eval("ImagePath") %>' 
                                                CssClass="rounded-4 me-3 shadow-sm border border-white" style="width: 100px; height: 70px; object-fit: cover;" />
                                        </div>
                                        <div>
                                            <div class="fw-800 text-dark fs-6 mb-1"><%# Eval("Title") %></div>
                                            <div class="d-flex align-items-center gap-3">
                                                <span class="text-muted small fw-bold"><i class="far fa-calendar-alt me-1 text-primary"></i><%# Eval("CreatedDate", "{0:dd MMM yyyy}") %></span>
                                                <span class="badge bg-light text-muted border small">News</span>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div class="p-2 bg-light rounded-4">
                                        <asp:TextBox ID="txtEditTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="luxury-input w-100 mb-2"></asp:TextBox>
                                        <asp:TextBox ID="txtEditShort" runat="server" Text='<%# Bind("ShortDesc") %>' TextMode="MultiLine" Rows="2" CssClass="luxury-input w-100 mb-2"></asp:TextBox>
                                        <asp:TextBox ID="txtEditContent" runat="server" Text='<%# Bind("Content") %>' TextMode="MultiLine" Rows="5" CssClass="luxury-input w-100"></asp:TextBox>
                                    </div>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="200">
                                <ItemTemplate>
                                    <div class="d-flex gap-2">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-white border rounded-pill px-3 shadow-sm fw-bold">
                                            <i class="fas fa-edit text-primary me-1"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-white border rounded-circle shadow-sm" OnClientClick="return confirm('Bhai, pakka delete karna hai?');">
                                            <i class="fas fa-trash-alt text-danger"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <div class="text-center">
                                        <div class="small fw-800 text-primary mb-2">Update Cover?</div>
                                        <asp:FileUpload ID="fuEditImage" runat="server" CssClass="form-control form-control-sm mb-3 rounded-pill" />
                                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-sm btn-dark w-100 mb-2 rounded-3 fw-bold">Save Changes</asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-outline-secondary w-100 rounded-3">Cancel</asp:LinkButton>
                                    </div>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Image Preview Logic
        function showPreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var img = document.getElementById('imgPreview');
                    img.src = e.target.result;
                    img.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>