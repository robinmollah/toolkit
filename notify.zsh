# Notify after successful or failed command
run_and_notify() {
  "$@" && \
    terminal-notifier -title "✅ Success" -message "Command '$*' completed." || \
    terminal-notifier -title "❌ Failed" -message "Command '$*' failed!"
}

