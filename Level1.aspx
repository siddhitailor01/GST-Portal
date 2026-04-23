<%@ Page Title="Level 1: Basic GST Foundation | Learn GST from Zero | GST Champions" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="Level1.aspx.cs" Inherits="Level1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Start your GST journey with Level 1: Foundation. Learn fundamental concepts, CGST, SGST, IGST, and registration processes in Rajasthan. Designed for beginners by Parikshit Mathur." />
    <meta name="keywords" content="GST Basics for Beginners, Learn CGST SGST, GST Registration Process Rajasthan, Basic Tax Concepts Bhilwara, Level 1 GST Course" />
    <link rel="canonical" href="https://www.gstchampions.in/Level1.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Course",
      "name": "Level 1: GST Foundations",
      "description": "Fundamental GST concepts and legal registration processes simplified for beginners in India.",
      "provider": {
        "@type": "Organization",
        "name": "GST Champions",
        "sameAs": "https://www.gstchampions.in/"
      },
      "hasCourseInstance": {
        "@type": "CourseInstance",
        "courseMode": "Online",
        "courseWorkload": "PT10H"
      },
      "educationalLevel": "Beginner"
    }
    </script>

    <style>
        :root { 
            --brand-primary: #6366f1; 
            --brand-secondary: #a855f7; 
            --brand-dark: #0f172a;
        }

        /* --- Compact Hero Header --- */
        .level-hero {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(99, 102, 241, 0.5)), 
                        url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?auto=format&fit=crop&q=80');
            background-size: cover;
            background-position: center;
            padding: 100px 0 80px; /* Reduced top and bottom padding */
            color: white;
            text-align: center;
            /*border-radius: 0 0 60px 60px;*/
            position: relative;
            overflow: hidden;
        }

        .level-hero h1 { font-weight: 900; letter-spacing: -2px; font-size: 3rem; }
        
        /* --- Overlapping Glassmorphic Search --- */
        .search-container { 
            margin-top: -65px; /* Pulled further up into the header */
            margin-bottom: 50px; 
            position: relative; 
            z-index: 20; 
        }
        
        .search-bar { 
            border-radius: 20px; 
            border: 1px solid rgba(255, 255, 255, 0.4); 
            padding: 18px 30px 18px 60px; 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.12); 
            width: 100%; 
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 1rem;
            font-weight: 600;
        }
        
        .search-bar:focus { 
            outline: none; 
            transform: translateY(-3px);
            border-color: var(--brand-primary); 
            box-shadow: 0 20px 45px rgba(99, 102, 241, 0.2); 
        }

        .search-wrapper { position: relative; }
        .search-wrapper i { 
            position: absolute; 
            left: 25px; 
            top: 50%; 
            transform: translateY(-50%); 
            color: var(--brand-primary);
            font-size: 1.1rem;
            z-index: 21;
        }

        /* --- Topic Cards Styling --- */
        .topic-card {
            border: 1px solid rgba(0,0,0,0.05);
            border-radius: 30px;
            overflow: hidden;
            transition: all 0.4s ease;
            background: white;
            position: relative;
        }

        .topic-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.08);
        }
        
        .step-number {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            color: white;
            width: 45px;
            height: 45px;
            line-height: 45px;
            border-radius: 14px;
            display: inline-block;
            text-align: center;
            font-weight: 800;
            margin-bottom: 20px;
            box-shadow: 0 5px 12px rgba(99, 102, 241, 0.25);
        }

        .topic-title { color: var(--brand-dark); font-weight: 900; letter-spacing: -0.5px; font-size: 1.4rem; }

        .btn-primary {
            background: var(--brand-dark);
            border: none;
            font-weight: 700;
            padding: 10px 22px;
            transition: 0.3s;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <header class="level-hero animate__animated animate__fadeIn">
        <div class="container">
            <span class="badge bg-info text-dark px-3 py-2 rounded-pill mb-3 fw-bold animate__animated animate__fadeInDown">STEP 01: BEGINNER</span>
            <h1 class="animate__animated animate__fadeInUp">Level 1: The Foundations</h1>
            <p class="lead opacity-75 mx-auto mb-4" style="max-width: 600px;">GST ki buniyad ko samjhein zero se professional level tak.</p>
        </div>
    </header>

    <div class="container py-5">
        <div class="row search-container justify-content-center">
            <div class="col-md-7 search-wrapper">
                <i class="fas fa-search"></i>
                <input type="text" id="topicSearch" class="search-bar" placeholder="Search topics (CGST, Registration, etc)..." onkeyup="searchFunction()">
            </div>
        </div>

        <div class="row g-4" id="topicList">
            <asp:Repeater ID="rptTopics" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 topic-item" data-aos="fade-up">
                        <div class="topic-card h-100 p-4 d-flex flex-column shadow-sm">
                            <div class="step-number shadow-sm">#<%# Container.ItemIndex + 1 %></div>
                            <h4 class="topic-title mb-3"><%# Eval("TopicName") %></h4>
                            <p class="text-muted flex-grow-1" style="line-height: 1.6; font-size: 0.95rem;">Basics aur legal concepts ko saral bhasha mein master karein.</p>
                            
                            <hr class="my-4 opacity-10" />
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-primary-subtle rounded-pill px-3 py-2">
                                    <i class="far fa-clock me-1"></i> Foundation
                                </span>
                                <a href='LessonDetail.aspx?TopicID=<%# Eval("TopicID") %>' class="btn btn-primary rounded-pill px-4 shadow-sm">
                                    Read <i class="fas fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            </div>
    </div>


    <script>
        function searchFunction() {
            var input = document.getElementById('topicSearch');
            var filter = input.value.toLowerCase();
            var nodes = document.getElementsByClassName('topic-item');
            var foundCount = 0;

            for (i = 0; i < nodes.length; i++) {
                // Topic name se match karein
                var title = nodes[i].querySelector('.topic-title').innerText.toLowerCase();
                if (title.includes(filter)) {
                    nodes[i].style.display = "";
                    foundCount++;
                } else {
                    nodes[i].style.display = "none";
                }
            }

            // Agar koi result nahi milta toh message dikhao
            var noResults = document.getElementById('noResults');
            if (foundCount === 0 && filter !== "") {
                noResults.style.display = "block";
            } else {
                noResults.style.display = "none";
            }
        }
    </script>
</asp:Content>