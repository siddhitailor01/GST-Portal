<%@ Page Title="GST Practice Quiz | Test Your Taxation Knowledge" Language="C#" MasterPageFile="~/UserMasterPage.master" AutoEventWireup="true" CodeFile="Quiz.aspx.cs" Inherits="Quiz" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <meta name="description" content="Take our interactive GST Practice Quiz to test your knowledge on HSN, SAC, and latest GST rules. Designed by Parikshit Mathur for students and tax experts in Bhilwara." />
    <meta name="keywords" content="GST Practice Quiz, GST MCQ Test Rajasthan, Online GST Exam Bhilwara, Free GST Certificate Course, HSN Knowledge Test" />
    <link rel="canonical" href="https://www.gstchampions.in/Quiz.aspx" />

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Quiz",
      "name": "GST Champions Practice Quiz",
      "hasPart": {
        "@type": "Question",
        "name": "Practice questions on GST levels 1, 2, and 3"
      },
      "educationalAlignment": [
        {
          "@type": "AlignmentObject",
          "alignmentType": "educationalLevel",
          "educationalFramework": "GST Learning Path",
          "targetName": "Basic to Advanced"
        }
      ],
      "publisher": {
        "@type": "Organization",
        "name": "GST Champions"
      }
    }
    </script>

    <style>
        :root { --gst-blue: #1e3a8a; --gst-accent: #3b82f6; --gst-light: #f8fafc; --gst-success: #22c55e; }
        body { background-color: var(--gst-light); }

        .quiz-wrapper { max-width: 800px; margin: 40px auto; }
        
        /* Premium Timer */
        .timer-box {
            background: white; padding: 12px 25px; border-radius: 50px;
            display: inline-flex; align-items: center; gap: 12px;
            box-shadow: 0 10px 25px rgba(30, 58, 138, 0.08);
            border: 1px solid rgba(30, 58, 138, 0.05);
        }
        .timer-clock { font-size: 1.6rem; font-weight: 800; color: var(--gst-blue); font-family: 'Monaco', monospace; }

        /* Sleek Progress Bar */
        .progress-container { margin: 35px 0; }
        .progress-label { display: flex; justify-content: space-between; margin-bottom: 10px; font-weight: 700; color: #64748b; font-size: 0.9rem; }
        .progress-stack { height: 12px; background: #e2e8f0; border-radius: 20px; overflow: hidden; box-shadow: inset 0 2px 4px rgba(0,0,0,0.05); }
.progress-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--gst-blue), var(--gst-accent));
    width: 0%; /* Start from 0 */
    transition: width 0.8s cubic-bezier(0.34, 1.56, 0.64, 1); /* Luxury bounce effect */
}
        /* Interactive Question Card */
        .q-card { 
            background: white; border-radius: 30px; padding: 50px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.03); border: 1px solid #f1f5f9;
            position: relative;
        }
        .question-text { font-size: 1.5rem; font-weight: 800; color: #0f172a; line-height: 1.4; margin-bottom: 35px; }

        /* Modern Radio Options */
        .option-list ul { list-style: none; padding: 0; margin: 0; }
        .option-list li { margin-bottom: 18px; }
        .option-list input[type="radio"] { display: none; }
        
        .option-list label {
            display: block; padding: 20px 25px; border: 2px solid #f1f5f9;
            border-radius: 18px; cursor: pointer; transition: all 0.25s ease;
            font-size: 1.1rem; color: #334155; font-weight: 600; background: #fff;
        }
        .option-list label:hover { border-color: var(--gst-accent); background: #f8fbff; transform: translateY(-2px); }
        .option-list input[type="radio"]:checked + label {
            border-color: var(--gst-blue); background: var(--gst-blue); color: white;
            box-shadow: 0 10px 25px rgba(30, 58, 138, 0.15);
        }

        /* Buttons */
        .btn-quiz { padding: 15px 45px; border-radius: 50px; font-weight: 800; text-transform: uppercase; letter-spacing: 1px; transition: 0.3s; border: none; }
        .btn-next { background: var(--gst-blue); color: white; }
        .btn-next:hover { background: #162a63; transform: scale(1.05); box-shadow: 0 10px 20px rgba(30, 58, 138, 0.2); }
        /* Timer Danger Pulse: Jab 30 second bachenge toh timer laal hokar pulse karega */
.timer-danger {
    color: #ef4444 !important;
    animation: pulse-red 1s infinite;
}

@keyframes pulse-red {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); box-shadow: 0 0 15px rgba(239, 68, 68, 0.4); }
    100% { transform: scale(1); }
}

/* Life-line Button Style */
.btn-lifeline {
    background: #fef3c7; color: #92400e; border: 2px solid #f59e0b;
    border-radius: 50px; font-weight: 700; transition: 0.3s;
}
.btn-lifeline:hover:not(:disabled) { background: #f59e0b; color: white; }
.btn-lifeline:disabled { opacity: 0.5; cursor: not-allowed; }

/* Option Selection Animation */
.option-list label:active { transform: scale(0.98); }

/* Custom Scrollbar for 100 questions grid */
.custom-scrollbar::-webkit-scrollbar { width: 5px; }
.custom-scrollbar::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
.custom-scrollbar::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
.custom-scrollbar::-webkit-scrollbar-thumb:hover { background: var(--gst-blue); }

/* Navigation Button States matching your logic */
.btn-outline-secondary { border: 2px solid #e2e8f0; color: #64748b; background: white; }
.btn-success { background: #dcfce7 !important; color: #166534 !important; border: 2px solid #22c55e !important; }
.btn-primary { background: var(--gst-blue) !important; color: white !important; border: 2px solid var(--gst-blue) !important; box-shadow: 0 4px 10px rgba(30,58,138,0.2); }

.nav-active-focus {
    border: 3px solid #3b82f6 !important;
    transform: scale(1.15);
    box-shadow: 0 0 15px rgba(59, 130, 246, 0.4);
    transition: all 0.3s ease;
    z-index: 10;
}

/* Smooth Scrolling for Navigator Container */
.custom-scrollbar {
    scroll-behavior: smooth;
    padding: 10px !important;
}

/* Card Polish */
.q-card { border-radius: 24px !important; border: 1px solid rgba(0,0,0,0.05) !important; }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <asp:ScriptManager ID="smQuiz" runat="server"></asp:ScriptManager>

<div class="container-fluid px-4 py-4">
    <div class="row g-4">
        <div class="col-lg-12">
            <div class="text-center mb-4 animate__animated animate__fadeInDown">
                <asp:Panel ID="pnlQuizHeader" runat="server">
                    <div class="timer-box shadow-sm">
                        <i class="fas fa-clock text-primary me-2"></i>
                        <span class="timer-clock" id="timeDisplay">03:00</span>
                    </div>
                </asp:Panel>
                <h2 class="fw-bold mt-3" style="color: var(--gst-blue);"><asp:Literal ID="litTopicHeading" runat="server"></asp:Literal></h2>
            </div>

            <asp:Panel ID="pnlMainQuizArea" runat="server">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <button type="button" id="btnLifeline" class="btn btn-lifeline px-4 py-2 shadow-sm" onclick="useLifeline()">
                        <i class="fas fa-magic me-2"></i> Use 50:50
                    </button>
                    <div class="text-muted small fw-bold">
                        <i class="fas fa-lightbulb text-warning me-1"></i> Tip: Use A, B, C, D keys!
                    </div>
                </div>

                <div class="q-card animate__animated animate__fadeInUp shadow-sm">
                    <asp:UpdatePanel ID="upQuiz" runat="server">
    <ContentTemplate>
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="progress-container">
                    <div class="progress-label">
                        <span>PROGRESS</span>
                        <span>Question <asp:Label ID="lblCurrentQ" runat="server"></asp:Label> / <asp:Label ID="lblTotalQ" runat="server"></asp:Label></span>
                    </div>
                    <div class="progress-stack">
                        <div class="progress-fill" id="progressBar" runat="server"></div>
                    </div>
                </div>

                <h4 class="question-text"><asp:Literal ID="litQuestionText" runat="server"></asp:Literal></h4>

                <div class="option-list">
                    <asp:RadioButtonList ID="rblOptions" runat="server" CssClass="w-100" RepeatLayout="UnorderedList"></asp:RadioButtonList>
                </div>

                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger border-0 rounded-4 mt-4 py-3">
                    <i class="fas fa-exclamation-circle me-2"></i> <strong>Rukiye!</strong> Option select karein.
                </asp:Panel>

                <div class="mt-5 d-flex justify-content-between border-top pt-4">
                    <asp:Button ID="btnPrev" runat="server" Text="&larr; Previous" CssClass="btn btn-secondary px-4 rounded-pill fw-bold" OnClick="btnPrev_Click" />
                    <div>
                        <asp:Button ID="btnNext" runat="server" Text="Save & Next &rarr;" CssClass="btn btn-quiz btn-next shadow" OnClick="btnNext_Click" />
                        <asp:Button ID="btnSubmit" runat="server" Text="Finish Assessment" CssClass="btn btn-success btn-quiz shadow" Visible="false" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center">
    <h6 class="fw-bold mb-0 text-dark"><i class="fas fa-th me-2 text-primary"></i>Question Navigator</h6>
    <span class="badge rounded-pill bg-primary-subtle text-primary fw-900 px-3 py-2" style="font-size: 0.75rem;">
        Attempted: <asp:Label ID="lblAnsweredCount" runat="server">0</asp:Label> / <asp:Label ID="lblTotalCountNav" runat="server"></asp:Label>
    </span>
</div>
                    <div class="card-body p-3">
                        <div style="max-height: 450px; overflow-y: auto; padding-right: 10px;" class="custom-scrollbar">
                            <div class="d-flex flex-wrap gap-2">
                                <asp:Repeater ID="rptNav" runat="server">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnJump" runat="server" 
                                            CssClass='<%# GetNavClass(Container.ItemIndex) %>' 
                                            style="width: 42px; height: 42px; display: flex; align-items: center; justify-content: center; font-weight: 800; border-radius: 12px; font-size: 0.85rem;"
                                            CommandArgument='<%# Container.ItemIndex %>' 
                                            OnClick="JumpToQuestion">
                                            <%# Container.ItemIndex + 1 %>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        
                        <div class="mt-4 pt-3 border-top d-flex justify-content-between small fw-bold text-muted">
                            <span><i class="fas fa-circle text-success me-1"></i> Answered</span>
                            <span><i class="fas fa-circle text-primary me-1"></i> Current</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
                </div>
            </asp:Panel>
        </div>

        
    </div>
</div>

<asp:Panel ID="pnlNoQuestions" runat="server" Visible="false" CssClass="text-center py-5">
    <div class="card shadow-sm p-5 border-0 rounded-4 mx-auto" style="max-width: 500px;">
        <h3 class="fw-bold">shama karein!</h3>
        <p class="text-muted">Is topic ke sawal jald hi add kiye jayenge.</p>
        <a href="Quiz.aspx" class="btn btn-primary rounded-pill px-5 py-2">Back to Mock Test</a>
    </div>
</asp:Panel>

    <asp:HiddenField ID="hfRemainingTime" runat="server" />
    <asp:HiddenField ID="hfCorrectAnswer" runat="server" ClientIDMode="Static" />
 <script>
     var seconds = parseInt(document.getElementById('<%= hfRemainingTime.ClientID %>').value) || 3600;
     var timer;

     function startTimer() {
         timer = setInterval(function () {
             var mins = Math.floor(seconds / 60);
             var secs = seconds % 60;
             var display = (mins < 10 ? "0" + mins : mins) + ":" + (secs < 10 ? "0" + secs : secs);
             var el = document.getElementById("timeDisplay");
             if (el) {
                 el.innerHTML = display;
                 if (seconds <= 300) el.classList.add("timer-danger");
             }
             if (seconds <= 0) {
                 clearInterval(timer);
                 alert("Time Over! Generating results...");
                 __doPostBack('<%= btnSubmit.UniqueID %>', 'timeout');
                }
                seconds--;
            }, 1000);
        }

        // Fixed Lifeline Logic: Protecting the Correct Answer
        function useLifeline() {
            var options = Array.from(document.querySelectorAll('.option-list li'));
            var correctAnswer = document.getElementById('hfCorrectAnswer').value.trim();
            
            // 1. Sirf galat answers ki list banao
            var wrongOptions = options.filter(function(li) {
                var val = li.querySelector('input').value;
                return val !== correctAnswer;
            });

            // 2. Galat options mein se 2 ko randomly gayab kar do
            wrongOptions.sort(() => 0.5 - Math.random());
            
            for (var i = 0; i < 2 && i < wrongOptions.length; i++) {
                wrongOptions[i].style.opacity = '0';
                wrongOptions[i].style.pointerEvents = 'none';
                wrongOptions[i].style.transform = 'scale(0.9)';
            }

            var btn = document.getElementById('btnLifeline');
            btn.disabled = true;
            btn.innerHTML = "<i class='fas fa-check-double me-2'></i> USED";
        }

        // Keyboard Shortcuts
        document.addEventListener('keydown', function(event) {
            const map = { 'A': 0, 'B': 1, 'C': 2, 'D': 3 };
            const key = event.key.toUpperCase();
            if (map.hasOwnProperty(key)) {
                var radios = document.querySelectorAll('.option-list input[type="radio"]');
                if (radios[map[key]]) { radios[map[key]].click(); }
            }
            if (event.key === 'Enter') {
                var btn = document.getElementById('<%= btnNext.ClientID %>') || document.getElementById('<%= btnSubmit.ClientID %>');
                    if (btn) btn.click();
                }
        });

     window.onload = startTimer;


     // Function to auto-scroll navigator to current question
     function scrollToCurrent() {
         // Current active number button dhundhna
         var activeBtn = document.querySelector('.btn-primary'); 
         var container = document.querySelector('.custom-scrollbar');
    
         if (activeBtn && container) {
             // Position calculate karke center mein lana
             var topPos = activeBtn.offsetTop - container.offsetTop - (container.clientHeight / 2) + (activeBtn.clientHeight / 2); 
             container.scrollTop = topPos;
        
             // Luxury focus class add karna
             activeBtn.classList.add('nav-active-focus');
         }
     }

     // UpdatePanel ke har refresh ke baad auto-scroll call karna
     var prm = Sys.WebForms.PageRequestManager.getInstance();
     prm.add_endRequest(function() {
         scrollToCurrent();
     });

     // Page load par pehli baar call karna
     window.addEventListener('load', function() {
         scrollToCurrent();
     });

    </script>

</asp:Content>