; ModuleID = 'libc-7cc09c32681a834f.bc'
source_filename = "libc.clk9c5ww-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"unix::linux_like::ip_mreq" = type { [0 x i32], %"unix::linux_like::in_addr", [0 x i32], %"unix::linux_like::in_addr", [0 x i32] }
%"unix::linux_like::in_addr" = type { [0 x i32], i32, [0 x i32] }
%"unix::linux_like::ip_mreq_source" = type { [0 x i32], %"unix::linux_like::in_addr", [0 x i32], %"unix::linux_like::in_addr", [0 x i32], %"unix::linux_like::in_addr", [0 x i32] }
%"unix::linux_like::arphdr" = type { [0 x i16], i16, [0 x i16], i16, [0 x i8], i8, [0 x i8], i8, [0 x i8], i16, [0 x i16] }
%"unix::linux_like::linux::fsid_t" = type { [0 x i32], [2 x i32], [0 x i32] }
%"unix::linux_like::linux::packet_mreq" = type { [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i8], [8 x i8], [0 x i8] }
%"unix::linux_like::linux::input_id" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::linux_like::linux::ff_envelope" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::linux_like::linux::ff_condition_effect" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::linux_like::linux::uinput_ff_erase" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::Elf32_Sym" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [0 x i8], i8, [0 x i8], i16, [0 x i16] }
%"unix::linux_like::linux::ucred" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::inotify_event" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::sockaddr_vm" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], i32, [0 x i8], [4 x i8], [0 x i8] }
%"unix::linux_like::linux::sock_extended_err" = type { [0 x i32], i32, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::input_mask" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64] }
%"unix::linux_like::linux::sock_filter" = type { [0 x i16], i16, [0 x i8], i8, [0 x i8], i8, [0 x i8], i32, [0 x i32] }
%"unix::linux_like::linux::nlmsghdr" = type { [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::sockaddr_nl" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::__c_anonymous_sockaddr_can_can_addr" = type { [2 x i64] }
%"unix::linux_like::linux::gnu::statx_timestamp" = type { [0 x i64], i64, [0 x i32], i32, [0 x i32], [1 x i32], [0 x i32] }
%"unix::linux_like::linux::gnu::cmsghdr" = type { [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::nl_mmap_req" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::Elf32_Chdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::sockaddr" = type { [0 x i16], i16, [0 x i8], [14 x i8], [0 x i8] }
%"unix::linux_like::sockaddr_in" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], %"unix::linux_like::in_addr", [0 x i8], [8 x i8], [0 x i8] }
%"unix::linux_like::linux::gnu::b64::x86_64::ip_mreqn" = type { [0 x i32], %"unix::linux_like::in_addr", [0 x i32], %"unix::linux_like::in_addr", [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::pthread_mutexattr_t" = type { [0 x i8], [4 x i8], [0 x i8] }
%"unix::linux_like::linux::can_frame" = type { [0 x i32], i32, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], [8 x i8], [0 x i8] }
%"unix::align::in6_addr" = type { [0 x i8], [16 x i8], [0 x i8] }
%"unix::linux_like::sched_param" = type { [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::af_alg_iv" = type { [0 x i32], i32, [0 x i8], [0 x i8], [0 x i8] }
%"unix::linux_like::linux::gnu::nl_pktinfo" = type { [0 x i32], i32, [0 x i32] }
%"unix::hostent" = type { [0 x i64], i8*, [0 x i64], i8**, [0 x i32], i32, [0 x i32], i32, [0 x i32], i8**, [0 x i64] }
%"unix::itimerval" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64] }
%"unix::group" = type { [0 x i64], i8*, [0 x i64], i8*, [0 x i32], i32, [1 x i32], i8**, [0 x i64] }
%"unix::servent" = type { [0 x i64], i8*, [0 x i64], i8**, [0 x i32], i32, [1 x i32], i8*, [0 x i64] }
%"unix::linux_like::sockaddr_ll" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i16], i16, [0 x i8], i8, [0 x i8], i8, [0 x i8], [8 x i8], [0 x i8] }
%"unix::linux_like::Dl_info" = type { [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::ifaddrs" = type { [0 x i64], %"unix::linux_like::ifaddrs"*, [0 x i64], i8*, [0 x i32], i32, [1 x i32], %"unix::linux_like::sockaddr"*, [0 x i64], %"unix::linux_like::sockaddr"*, [0 x i64], %"unix::linux_like::sockaddr"*, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::sockaddr_storage" = type { [0 x i16], i16, [3 x i16], i64, [0 x i8], [112 x i8], [0 x i8] }
%"unix::linux_like::sigevent" = type { [0 x i64], %"unix::sigval", [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], [11 x i32], [0 x i32] }
%"unix::sigval" = type { [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::linux::passwd" = type { [0 x i64], i8*, [0 x i64], i8*, [0 x i32], i32, [0 x i32], i32, [0 x i32], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::linux::glob_t" = type { [0 x i64], i64, [0 x i64], i8**, [0 x i64], i64, [0 x i32], i32, [1 x i32], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::linux::dqblk" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [1 x i32] }
%"unix::linux_like::linux::signalfd_siginfo" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], i64, [0 x i32], i32, [0 x i8], [28 x i8], [0 x i8] }
%"unix::linux_like::linux::itimerspec" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64] }
%"unix::linux_like::linux::cpu_set_t" = type { [0 x i64], [16 x i64], [0 x i64] }
%"unix::linux_like::linux::input_event" = type { [0 x i64], { i64, i64 }, [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32] }
%"unix::linux_like::linux::ff_periodic_effect" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], %"unix::linux_like::linux::ff_envelope", [1 x i16], i32, [0 x i32], i16*, [0 x i64] }
%"unix::linux_like::linux::ff_effect" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], { i16, i16 }, [0 x i16], { i16, i16 }, [1 x i16], [4 x i64], [0 x i64] }
%"unix::linux_like::linux::uinput_abs_setup" = type { [0 x i16], i16, [1 x i16], %"unix::linux_like::linux::input_absinfo", [0 x i32] }
%"unix::linux_like::linux::input_absinfo" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::dl_phdr_info" = type { [0 x i64], i64, [0 x i64], i8*, [0 x i64], %"unix::linux_like::linux::Elf64_Phdr"*, [0 x i16], i16, [3 x i16], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::linux::Elf64_Phdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::Elf64_Sym" = type { [0 x i32], i32, [0 x i8], i8, [0 x i8], i8, [0 x i8], i16, [0 x i16], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::Elf32_Phdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::Elf64_Shdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::posix_spawn_file_actions_t" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32*, [0 x i32], [16 x i32], [0 x i32] }
%"unix::linux_like::linux::in6_pktinfo" = type { [0 x i32], %"unix::align::in6_addr", [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::arpd_request" = type { [0 x i16], i16, [1 x i16], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i8], [7 x i8], [1 x i8] }
%"unix::linux_like::linux::seccomp_data" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], [6 x i64], [0 x i64] }
%"unix::linux_like::linux::nlmsgerr" = type { [0 x i32], i32, [0 x i32], %"unix::linux_like::linux::nlmsghdr", [0 x i32] }
%"unix::linux_like::linux::dirent64" = type { [0 x i64], i64, [0 x i64], i64, [0 x i16], i16, [0 x i8], i8, [0 x i8], [256 x i8], [5 x i8] }
%"unix::linux_like::linux::mq_attr" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], [4 x i64], [0 x i64] }
%"unix::linux_like::linux::sockaddr_can" = type { [0 x i16], i16, [1 x i16], i32, [0 x i32], %"unix::linux_like::linux::__c_anonymous_sockaddr_can_can_addr", [0 x i64] }
%"unix::linux_like::linux::gnu::glob64_t" = type { [0 x i64], i64, [0 x i64], i8**, [0 x i64], i64, [0 x i32], i32, [1 x i32], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::linux::gnu::msghdr" = type { [0 x i64], i8*, [0 x i32], i32, [1 x i32], { i8*, i64 }*, [0 x i64], i64, [0 x i64], i8*, [0 x i64], i64, [0 x i32], i32, [1 x i32] }
%"unix::linux_like::linux::gnu::mallinfo" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::mallinfo2" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::nl_mmap_hdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::ntptimeval" = type { [0 x i64], { i64, i64 }, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::regex_t" = type { [0 x i64], i8*, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i64, [0 x i8], i8, [7 x i8] }
%"unix::linux_like::linux::gnu::Elf64_Chdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::seminfo" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::sifields_sigchld" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [1 x i32], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::sigset_t" = type { [0 x i64], [16 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::msqid_ds" = type { [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm", [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [2 x i16], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::semid_ds" = type { [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm", [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::statfs" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], %"unix::linux_like::linux::fsid_t", [0 x i32], i64, [0 x i64], i64, [0 x i64], [5 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::flock" = type { [0 x i16], i16, [0 x i16], i16, [2 x i16], i64, [0 x i64], i64, [0 x i32], i32, [1 x i32] }
%"unix::linux_like::linux::gnu::b64::x86_64::flock64" = type { [0 x i16], i16, [0 x i16], i16, [2 x i16], i64, [0 x i64], i64, [0 x i32], i32, [1 x i32] }
%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], [29 x i32], [0 x i32], [0 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::stack_t" = type { [0 x i64], i8*, [0 x i32], i32, [1 x i32], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::stat" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], [3 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::stat64" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], [3 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::statfs64" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], %"unix::linux_like::linux::fsid_t", [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], [4 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::statvfs64" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], [6 x i32], [0 x i32] }
%"unix::linux_like::tm" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [1 x i32], i64, [0 x i64], i8*, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::mcontext_t" = type { [0 x i64], [23 x i64], [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"*, [0 x i64], [8 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i16], [8 x %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpxreg"], [0 x i16], [16 x %"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"], [0 x i32], [12 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpxreg" = type { [0 x i16], [4 x i16], [0 x i16], i16, [0 x i16], [3 x i16], [0 x i16] }
%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg" = type { [0 x i32], [4 x i32], [0 x i32] }
%"unix::linux_like::linux::gnu::b64::x86_64::shmid_ds" = type { [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm", [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], [32 x i32], [0 x i32], [64 x i32], [0 x i32], [24 x i32], [0 x i32] }
%"unix::linux_like::linux::gnu::b64::sysinfo" = type { [0 x i64], i64, [0 x i64], [3 x i64], [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i16], i16, [0 x i16], i16, [2 x i16], i64, [0 x i64], i64, [0 x i32], i32, [0 x i8], [0 x i8], [4 x i8] }
%"unix::linux_like::linux::fanotify_event_metadata" = type { [0 x i32], i32, [0 x i8], i8, [0 x i8], i8, [0 x i8], i16, [0 x i16], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::canfd_frame" = type { [0 x i32], i32, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], [64 x i8], [0 x i8] }
%"unix::FILE" = type { [0 x i8] }
%"unix::fpos_t" = type { [0 x i8] }
%"unix::linux_like::timezone" = type { [0 x i8] }
%"unix::linux_like::linux::fpos64_t" = type { [0 x i8] }
%"unix::DIR" = type { [0 x i8] }
%"unix::rusage" = type { [0 x i64], { i64, i64 }, [0 x i64], { i64, i64 }, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::ipv6_mreq" = type { [0 x i32], %"unix::align::in6_addr", [0 x i32], i32, [0 x i32] }
%"unix::pollfd" = type { [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::winsize" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::tms" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::protoent" = type { [0 x i64], i8*, [0 x i64], i8**, [0 x i32], i32, [1 x i32] }
%"unix::linux_like::sockaddr_in6" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], %"unix::align::in6_addr", [0 x i32], i32, [0 x i32] }
%"unix::linux_like::addrinfo" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [1 x i32], %"unix::linux_like::sockaddr"*, [0 x i64], i8*, [0 x i64], %"unix::linux_like::addrinfo"*, [0 x i64] }
%"unix::linux_like::fd_set" = type { [0 x i64], [16 x i64], [0 x i64] }
%"unix::linux_like::lconv" = type { [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [2 x i8] }
%"unix::linux_like::in_pktinfo" = type { [0 x i32], i32, [0 x i32], %"unix::linux_like::in_addr", [0 x i32], %"unix::linux_like::in_addr", [0 x i32] }
%"unix::linux_like::in6_rtmsg" = type { [0 x i32], %"unix::align::in6_addr", [0 x i32], %"unix::align::in6_addr", [0 x i32], %"unix::align::in6_addr", [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16], i32, [1 x i32], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::arpreq" = type { [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], i32, [0 x i16], %"unix::linux_like::sockaddr", [0 x i8], [16 x i8], [0 x i8] }
%"unix::linux_like::arpreq_old" = type { [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], i32, [0 x i16], %"unix::linux_like::sockaddr", [0 x i16] }
%"unix::linux_like::mmsghdr" = type { [0 x i64], %"unix::linux_like::linux::gnu::msghdr", [0 x i32], i32, [1 x i32] }
%"unix::linux_like::epoll_event" = type <{ [0 x i8], i32, [0 x i8], i64, [0 x i8] }>
%"unix::linux_like::sockaddr_un" = type { [0 x i16], i16, [0 x i8], [108 x i8], [0 x i8] }
%"unix::linux_like::utsname" = type { [0 x i8], [65 x i8], [0 x i8], [65 x i8], [0 x i8], [65 x i8], [0 x i8], [65 x i8], [0 x i8], [65 x i8], [0 x i8], [65 x i8], [0 x i8] }
%"unix::linux_like::linux::spwd" = type { [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::msginfo" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i16], i16, [1 x i16] }
%"unix::linux_like::linux::sembuf" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::linux_like::linux::input_keymap_entry" = type { [0 x i8], i8, [0 x i8], i8, [0 x i8], i16, [0 x i16], i32, [0 x i8], [32 x i8], [0 x i8] }
%"unix::linux_like::linux::ff_constant_effect" = type { [0 x i16], i16, [0 x i16], %"unix::linux_like::linux::ff_envelope", [0 x i16] }
%"unix::linux_like::linux::ff_ramp_effect" = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], %"unix::linux_like::linux::ff_envelope", [0 x i16] }
%"unix::linux_like::linux::uinput_ff_upload" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], %"unix::linux_like::linux::ff_effect", [0 x i64], %"unix::linux_like::linux::ff_effect", [0 x i64] }
%"unix::linux_like::linux::Elf32_Ehdr" = type { [0 x i8], [16 x i8], [0 x i8], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::linux_like::linux::Elf64_Ehdr" = type { [0 x i8], [16 x i8], [0 x i8], i16, [0 x i16], i16, [0 x i16], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"unix::linux_like::linux::Elf32_Shdr" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::mntent" = type { [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i64], i8*, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::posix_spawnattr_t" = type { [0 x i16], i16, [1 x i16], i32, [0 x i32], %"unix::linux_like::linux::gnu::b64::sigset_t", [0 x i64], %"unix::linux_like::linux::gnu::b64::sigset_t", [0 x i32], %"unix::linux_like::sched_param", [0 x i32], i32, [0 x i32], [16 x i32], [0 x i32] }
%"unix::linux_like::linux::genlmsghdr" = type { [0 x i8], i8, [0 x i8], i8, [0 x i8], i16, [0 x i16] }
%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939" = type { [0 x i64], i64, [0 x i32], i32, [0 x i8], i8, [3 x i8] }
%"unix::linux_like::linux::dirent" = type { [0 x i64], i64, [0 x i64], i64, [0 x i16], i16, [0 x i8], i8, [0 x i8], [256 x i8], [5 x i8] }
%"unix::linux_like::linux::sockaddr_alg" = type { [0 x i16], i16, [0 x i8], [14 x i8], [0 x i8], i32, [0 x i32], i32, [0 x i8], [64 x i8], [0 x i8] }
%"unix::linux_like::linux::uinput_setup" = type { [0 x i16], %"unix::linux_like::linux::input_id", [0 x i8], [80 x i8], [0 x i8], i32, [0 x i32] }
%"unix::linux_like::linux::uinput_user_dev" = type { [0 x i8], [80 x i8], [0 x i8], %"unix::linux_like::linux::input_id", [0 x i16], i32, [0 x i32], [64 x i32], [0 x i32], [64 x i32], [0 x i32], [64 x i32], [0 x i32], [64 x i32], [0 x i32] }
%"unix::linux_like::linux::gnu::statx" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i16], i16, [0 x i16], [1 x i16], [0 x i16], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], %"unix::linux_like::linux::gnu::statx_timestamp", [0 x i64], %"unix::linux_like::linux::gnu::statx_timestamp", [0 x i64], %"unix::linux_like::linux::gnu::statx_timestamp", [0 x i64], %"unix::linux_like::linux::gnu::statx_timestamp", [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i64, [0 x i64], i64, [0 x i64], [12 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::aiocb" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [1 x i32], i8*, [0 x i64], i64, [0 x i64], %"unix::linux_like::sigevent", [0 x i64], %"unix::linux_like::linux::gnu::aiocb"*, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [1 x i32], i64, [0 x i64], i64, [0 x i8], [32 x i8], [0 x i8] }
%"unix::linux_like::linux::gnu::termios" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [0 x i8], [32 x i8], [3 x i8], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::rtentry" = type { [0 x i64], i64, [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], %"unix::linux_like::sockaddr", [0 x i16], i16, [0 x i16], i16, [2 x i16], i64, [0 x i8], i8, [0 x i8], i8, [0 x i8], [3 x i16], [0 x i16], i16, [3 x i16], i8*, [0 x i64], i64, [0 x i64], i64, [0 x i16], i16, [3 x i16] }
%"unix::linux_like::linux::gnu::timex" = type { [0 x i32], i32, [1 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [1 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], { i64, i64 }, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [1 x i32], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::utmpx" = type { [0 x i16], i16, [1 x i16], i32, [0 x i8], [32 x i8], [0 x i8], [4 x i8], [0 x i8], [32 x i8], [0 x i8], [256 x i8], [0 x i8], { i16, i16 }, [0 x i16], i32, [0 x i32], { i32, i32 }, [0 x i32], [4 x i32], [0 x i8], [20 x i8], [0 x i8] }
%"unix::linux_like::linux::gnu::b64::x86_64::sigaction" = type { [0 x i64], i64, [0 x i64], %"unix::linux_like::linux::gnu::b64::sigset_t", [0 x i32], i32, [1 x i32], i64*, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t" = type { [0 x i64], [7 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::user" = type { [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct", [0 x i32], i32, [1 x i32], %"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct", [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], i32, [1 x i32], %"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct"*, [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct"*, [0 x i64], i64, [0 x i8], [32 x i8], [0 x i8], [8 x i64], [0 x i64] }
%"unix::linux_like::linux::gnu::b64::x86_64::termios2" = type { [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i32], i32, [0 x i8], i8, [0 x i8], [19 x i8], [0 x i8], i32, [0 x i32], i32, [0 x i32] }
%"unix::linux_like::linux::gnu::b64::x86_64::ucontext_t" = type { [0 x i64], i64, [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::ucontext_t"*, [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::stack_t", [0 x i64], %"unix::linux_like::linux::gnu::b64::x86_64::mcontext_t", [0 x i64], %"unix::linux_like::linux::gnu::b64::sigset_t", [0 x i8], [512 x i8], [0 x i8] }
%"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs" = type { [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i64], i64, [0 x i32], [6 x i32], [0 x i32] }
%"unix::linux_like::linux::gnu::b64::x86_64::align::max_align_t" = type { [0 x i64], [4 x double], [0 x i64] }
%"unix::linux_like::linux::gnu::align::sem_t" = type { [0 x i8], [32 x i8], [0 x i8] }
%"unix::linux_like::linux::pthread_rwlockattr_t" = type { [0 x i8], [8 x i8], [0 x i8] }
%"unix::linux_like::linux::pthread_condattr_t" = type { [0 x i8], [4 x i8], [0 x i8] }
%"unix::linux_like::linux::pthread_cond_t" = type { [0 x i8], [48 x i8], [0 x i8] }
%"unix::linux_like::linux::pthread_mutex_t" = type { [0 x i8], [40 x i8], [0 x i8] }
%"unix::linux_like::linux::pthread_rwlock_t" = type { [0 x i8], [56 x i8], [0 x i8] }

@"_ZN70_$LT$libc..unix..linux_like..ip_mreq$u20$as$u20$core..clone..Clone$GT$5clone17h9ecd20c4eef24cd6E" = unnamed_addr alias i64 (%"unix::linux_like::ip_mreq"*), bitcast (i64 (%"unix::pollfd"*)* @"_ZN57_$LT$libc..unix..pollfd$u20$as$u20$core..clone..Clone$GT$5clone17h4c92e15de06ca525E" to i64 (%"unix::linux_like::ip_mreq"*)*)
@"_ZN77_$LT$libc..unix..linux_like..ip_mreq_source$u20$as$u20$core..clone..Clone$GT$5clone17hf7322a76a5c4022aE" = unnamed_addr alias i96 (%"unix::linux_like::ip_mreq_source"*), bitcast (i96 (%"unix::linux_like::in_pktinfo"*)* @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E" to i96 (%"unix::linux_like::ip_mreq_source"*)*)
@"_ZN69_$LT$libc..unix..linux_like..arphdr$u20$as$u20$core..clone..Clone$GT$5clone17h031a3234c5d78d71E" = unnamed_addr alias i64 (%"unix::linux_like::arphdr"*), bitcast (i64 (%"unix::winsize"*)* @"_ZN58_$LT$libc..unix..winsize$u20$as$u20$core..clone..Clone$GT$5clone17h7c80d5408b1bcb83E" to i64 (%"unix::linux_like::arphdr"*)*)
@"_ZN76_$LT$libc..unix..linux_like..linux..fsid_t$u20$as$u20$core..clone..Clone$GT$5clone17hcfe2f0bfdc93d06bE" = unnamed_addr alias i64 (%"unix::linux_like::linux::fsid_t"*), bitcast (i64 (%"unix::pollfd"*)* @"_ZN57_$LT$libc..unix..pollfd$u20$as$u20$core..clone..Clone$GT$5clone17h4c92e15de06ca525E" to i64 (%"unix::linux_like::linux::fsid_t"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..packet_mreq$u20$as$u20$core..clone..Clone$GT$5clone17h3120b34e6c780413E" = unnamed_addr alias i128 (%"unix::linux_like::linux::packet_mreq"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::packet_mreq"*)*)
@"_ZN78_$LT$libc..unix..linux_like..linux..input_id$u20$as$u20$core..clone..Clone$GT$5clone17hcaadb4b5c66c7780E" = unnamed_addr alias i64 (%"unix::linux_like::linux::input_id"*), bitcast (i64 (%"unix::winsize"*)* @"_ZN58_$LT$libc..unix..winsize$u20$as$u20$core..clone..Clone$GT$5clone17h7c80d5408b1bcb83E" to i64 (%"unix::linux_like::linux::input_id"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..ff_envelope$u20$as$u20$core..clone..Clone$GT$5clone17h8855179fd67791ccE" = unnamed_addr alias i64 (%"unix::linux_like::linux::ff_envelope"*), bitcast (i64 (%"unix::winsize"*)* @"_ZN58_$LT$libc..unix..winsize$u20$as$u20$core..clone..Clone$GT$5clone17h7c80d5408b1bcb83E" to i64 (%"unix::linux_like::linux::ff_envelope"*)*)
@"_ZN89_$LT$libc..unix..linux_like..linux..ff_condition_effect$u20$as$u20$core..clone..Clone$GT$5clone17hef09dd08cffbfc61E" = unnamed_addr alias i96 (%"unix::linux_like::linux::ff_condition_effect"*), bitcast (i96 (%"unix::linux_like::linux::ff_ramp_effect"*)* @"_ZN84_$LT$libc..unix..linux_like..linux..ff_ramp_effect$u20$as$u20$core..clone..Clone$GT$5clone17h327902ed483ee6efE" to i96 (%"unix::linux_like::linux::ff_condition_effect"*)*)
@"_ZN85_$LT$libc..unix..linux_like..linux..uinput_ff_erase$u20$as$u20$core..clone..Clone$GT$5clone17h8fdf106512770215E" = unnamed_addr alias i96 (%"unix::linux_like::linux::uinput_ff_erase"*), bitcast (i96 (%"unix::linux_like::in_pktinfo"*)* @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E" to i96 (%"unix::linux_like::linux::uinput_ff_erase"*)*)
@"_ZN79_$LT$libc..unix..linux_like..linux..Elf32_Sym$u20$as$u20$core..clone..Clone$GT$5clone17hdbabd78563741093E" = unnamed_addr alias i128 (%"unix::linux_like::linux::Elf32_Sym"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::Elf32_Sym"*)*)
@"_ZN75_$LT$libc..unix..linux_like..linux..ucred$u20$as$u20$core..clone..Clone$GT$5clone17h073e4002af0e1611E" = unnamed_addr alias i96 (%"unix::linux_like::linux::ucred"*), bitcast (i96 (%"unix::linux_like::in_pktinfo"*)* @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E" to i96 (%"unix::linux_like::linux::ucred"*)*)
@"_ZN83_$LT$libc..unix..linux_like..linux..inotify_event$u20$as$u20$core..clone..Clone$GT$5clone17h8f5f0fa236f35fcbE" = unnamed_addr alias i128 (%"unix::linux_like::linux::inotify_event"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::inotify_event"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..sockaddr_vm$u20$as$u20$core..clone..Clone$GT$5clone17h36ada946d20a5aa7E" = unnamed_addr alias i128 (%"unix::linux_like::linux::sockaddr_vm"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::sockaddr_vm"*)*)
@"_ZN87_$LT$libc..unix..linux_like..linux..sock_extended_err$u20$as$u20$core..clone..Clone$GT$5clone17h5faa31c26da0780dE" = unnamed_addr alias i128 (%"unix::linux_like::linux::sock_extended_err"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::sock_extended_err"*)*)
@"_ZN80_$LT$libc..unix..linux_like..linux..input_mask$u20$as$u20$core..clone..Clone$GT$5clone17h26bc3afd31d2b22bE" = unnamed_addr alias i128 (%"unix::linux_like::linux::input_mask"*), bitcast (i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_j1939$u20$as$u20$core..clone..Clone$GT$5clone17h0929051400ce0ceaE" to i128 (%"unix::linux_like::linux::input_mask"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..sock_filter$u20$as$u20$core..clone..Clone$GT$5clone17h31cb0c0a0946cb39E" = unnamed_addr alias i64 (%"unix::linux_like::linux::sock_filter"*), bitcast (i64 (%"unix::pollfd"*)* @"_ZN57_$LT$libc..unix..pollfd$u20$as$u20$core..clone..Clone$GT$5clone17h4c92e15de06ca525E" to i64 (%"unix::linux_like::linux::sock_filter"*)*)
@"_ZN78_$LT$libc..unix..linux_like..linux..nlmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h42f262775ecec0f7E" = unnamed_addr alias i128 (%"unix::linux_like::linux::nlmsghdr"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::nlmsghdr"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..sockaddr_nl$u20$as$u20$core..clone..Clone$GT$5clone17h890d5216b34bf8bdE" = unnamed_addr alias i96 (%"unix::linux_like::linux::sockaddr_nl"*), bitcast (i96 (%"unix::linux_like::in_pktinfo"*)* @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E" to i96 (%"unix::linux_like::linux::sockaddr_nl"*)*)
@"_ZN105_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_can_addr$u20$as$u20$core..clone..Clone$GT$5clone17hacd48a3962b275d2E" = unnamed_addr alias i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_can_addr"*), bitcast (i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_j1939$u20$as$u20$core..clone..Clone$GT$5clone17h0929051400ce0ceaE" to i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_can_addr"*)*)
@"_ZN90_$LT$libc..unix..linux_like..linux..gnu..statx_timestamp$u20$as$u20$core..clone..Clone$GT$5clone17hb2ffb1313d6a5c98E" = unnamed_addr alias i128 (%"unix::linux_like::linux::gnu::statx_timestamp"*), bitcast (i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_j1939$u20$as$u20$core..clone..Clone$GT$5clone17h0929051400ce0ceaE" to i128 (%"unix::linux_like::linux::gnu::statx_timestamp"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..gnu..cmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17hbae76798c1e0378cE" = unnamed_addr alias i128 (%"unix::linux_like::linux::gnu::cmsghdr"*), bitcast (i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_j1939$u20$as$u20$core..clone..Clone$GT$5clone17h0929051400ce0ceaE" to i128 (%"unix::linux_like::linux::gnu::cmsghdr"*)*)
@"_ZN86_$LT$libc..unix..linux_like..linux..gnu..nl_mmap_req$u20$as$u20$core..clone..Clone$GT$5clone17h456e3a9e18221e38E" = unnamed_addr alias i128 (%"unix::linux_like::linux::gnu::nl_mmap_req"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::linux::gnu::nl_mmap_req"*)*)
@"_ZN85_$LT$libc..unix..linux_like..linux..gnu..Elf32_Chdr$u20$as$u20$core..clone..Clone$GT$5clone17h32defd1bb47a5b1eE" = unnamed_addr alias i96 (%"unix::linux_like::linux::gnu::Elf32_Chdr"*), bitcast (i96 (%"unix::linux_like::in_pktinfo"*)* @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E" to i96 (%"unix::linux_like::linux::gnu::Elf32_Chdr"*)*)
@"_ZN71_$LT$libc..unix..linux_like..sockaddr$u20$as$u20$core..clone..Clone$GT$5clone17h57a1e9507d1eaff5E" = unnamed_addr alias i128 (%"unix::linux_like::sockaddr"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpxreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_fpxreg$u20$as$u20$core..clone..Clone$GT$5clone17ha2879f88ccf1e663E" to i128 (%"unix::linux_like::sockaddr"*)*)
@"_ZN74_$LT$libc..unix..linux_like..sockaddr_in$u20$as$u20$core..clone..Clone$GT$5clone17hc8fa9c1b76db6665E" = unnamed_addr alias i128 (%"unix::linux_like::sockaddr_in"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::linux_like::sockaddr_in"*)*)
@"_ZN96_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..ip_mreqn$u20$as$u20$core..clone..Clone$GT$5clone17h70a5b602b8a6cd34E" = unnamed_addr alias i96 (%"unix::linux_like::linux::gnu::b64::x86_64::ip_mreqn"*), bitcast (i96 (%"unix::linux_like::in_pktinfo"*)* @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E" to i96 (%"unix::linux_like::linux::gnu::b64::x86_64::ip_mreqn"*)*)
@"_ZN89_$LT$libc..unix..linux_like..linux..pthread_mutexattr_t$u20$as$u20$core..clone..Clone$GT$5clone17h12b3e9ff2d0f8f55E" = unnamed_addr alias i32 (%"unix::linux_like::linux::pthread_mutexattr_t"*), bitcast (i32 (%"unix::linux_like::linux::pthread_condattr_t"*)* @"_ZN88_$LT$libc..unix..linux_like..linux..pthread_condattr_t$u20$as$u20$core..clone..Clone$GT$5clone17h0a100297856cd22aE" to i32 (%"unix::linux_like::linux::pthread_mutexattr_t"*)*)
@"_ZN79_$LT$libc..unix..linux_like..linux..can_frame$u20$as$u20$core..clone..Clone$GT$5clone17he55ad88867aeea82E" = unnamed_addr alias i128 (%"unix::linux_like::linux::can_frame"*), bitcast (i128 (%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_j1939$u20$as$u20$core..clone..Clone$GT$5clone17h0929051400ce0ceaE" to i128 (%"unix::linux_like::linux::can_frame"*)*)
@"_ZN66_$LT$libc..unix..align..in6_addr$u20$as$u20$core..clone..Clone$GT$5clone17hae604ef575689026E" = unnamed_addr alias i128 (%"unix::align::in6_addr"*), bitcast (i128 (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"*)* @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E" to i128 (%"unix::align::in6_addr"*)*)
@"_ZN74_$LT$libc..unix..linux_like..sched_param$u20$as$u20$core..clone..Clone$GT$5clone17h3a25893a37f1b2baE" = unnamed_addr alias i32 (%"unix::linux_like::sched_param"*), bitcast (i32 (%"unix::linux_like::in_addr"*)* @"_ZN70_$LT$libc..unix..linux_like..in_addr$u20$as$u20$core..clone..Clone$GT$5clone17hcc6b6fd29e52fb45E" to i32 (%"unix::linux_like::sched_param"*)*)
@"_ZN79_$LT$libc..unix..linux_like..linux..af_alg_iv$u20$as$u20$core..clone..Clone$GT$5clone17hef53f3573728b677E" = unnamed_addr alias i32 (%"unix::linux_like::linux::af_alg_iv"*), bitcast (i32 (%"unix::linux_like::in_addr"*)* @"_ZN70_$LT$libc..unix..linux_like..in_addr$u20$as$u20$core..clone..Clone$GT$5clone17hcc6b6fd29e52fb45E" to i32 (%"unix::linux_like::linux::af_alg_iv"*)*)
@"_ZN85_$LT$libc..unix..linux_like..linux..gnu..nl_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17h05c19fa390aa1763E" = unnamed_addr alias i32 (%"unix::linux_like::linux::gnu::nl_pktinfo"*), bitcast (i32 (%"unix::linux_like::in_addr"*)* @"_ZN70_$LT$libc..unix..linux_like..in_addr$u20$as$u20$core..clone..Clone$GT$5clone17hcc6b6fd29e52fb45E" to i32 (%"unix::linux_like::linux::gnu::nl_pktinfo"*)*)
@"_ZN58_$LT$libc..unix..hostent$u20$as$u20$core..clone..Clone$GT$5clone17hbc7428cb86f39817E" = unnamed_addr alias void (%"unix::hostent"*, %"unix::hostent"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::hostent"*, %"unix::hostent"*)*)
@"_ZN60_$LT$libc..unix..itimerval$u20$as$u20$core..clone..Clone$GT$5clone17h4f6e9a1b1b84ce86E" = unnamed_addr alias void (%"unix::itimerval"*, %"unix::itimerval"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::itimerval"*, %"unix::itimerval"*)*)
@"_ZN56_$LT$libc..unix..group$u20$as$u20$core..clone..Clone$GT$5clone17haba9ddb72e3568a3E" = unnamed_addr alias void (%"unix::group"*, %"unix::group"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::group"*, %"unix::group"*)*)
@"_ZN58_$LT$libc..unix..servent$u20$as$u20$core..clone..Clone$GT$5clone17h80f75dcff02e1a13E" = unnamed_addr alias void (%"unix::servent"*, %"unix::servent"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::servent"*, %"unix::servent"*)*)
@"_ZN74_$LT$libc..unix..linux_like..sockaddr_ll$u20$as$u20$core..clone..Clone$GT$5clone17h25b5b4257183ce35E" = unnamed_addr alias void (%"unix::linux_like::sockaddr_ll"*, %"unix::linux_like::sockaddr_ll"*), bitcast (void (%"unix::ipv6_mreq"*, %"unix::ipv6_mreq"*)* @"_ZN60_$LT$libc..unix..ipv6_mreq$u20$as$u20$core..clone..Clone$GT$5clone17h3f43912004402d0aE" to void (%"unix::linux_like::sockaddr_ll"*, %"unix::linux_like::sockaddr_ll"*)*)
@"_ZN70_$LT$libc..unix..linux_like..Dl_info$u20$as$u20$core..clone..Clone$GT$5clone17h14d6982dd9ee7ff6E" = unnamed_addr alias void (%"unix::linux_like::Dl_info"*, %"unix::linux_like::Dl_info"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::linux_like::Dl_info"*, %"unix::linux_like::Dl_info"*)*)
@"_ZN70_$LT$libc..unix..linux_like..ifaddrs$u20$as$u20$core..clone..Clone$GT$5clone17h7fb30ec9bcaf621cE" = unnamed_addr alias void (%"unix::linux_like::ifaddrs"*, %"unix::linux_like::ifaddrs"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..pthread_attr_t$u20$as$u20$core..clone..Clone$GT$5clone17h22da86904259d03fE" to void (%"unix::linux_like::ifaddrs"*, %"unix::linux_like::ifaddrs"*)*)
@"_ZN79_$LT$libc..unix..linux_like..sockaddr_storage$u20$as$u20$core..clone..Clone$GT$5clone17h56f2e3333f321cddE" = unnamed_addr alias void (%"unix::linux_like::sockaddr_storage"*, %"unix::linux_like::sockaddr_storage"*), bitcast (void (%"unix::linux_like::fd_set"*, %"unix::linux_like::fd_set"*)* @"_ZN69_$LT$libc..unix..linux_like..fd_set$u20$as$u20$core..clone..Clone$GT$5clone17h6589b1322586f879E" to void (%"unix::linux_like::sockaddr_storage"*, %"unix::linux_like::sockaddr_storage"*)*)
@"_ZN71_$LT$libc..unix..linux_like..sigevent$u20$as$u20$core..clone..Clone$GT$5clone17h93390654f4e2401aE" = unnamed_addr alias void (%"unix::linux_like::sigevent"*, %"unix::linux_like::sigevent"*), bitcast (void (%"unix::linux_like::mmsghdr"*, %"unix::linux_like::mmsghdr"*)* @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE" to void (%"unix::linux_like::sigevent"*, %"unix::linux_like::sigevent"*)*)
@"_ZN76_$LT$libc..unix..linux_like..linux..passwd$u20$as$u20$core..clone..Clone$GT$5clone17h53d76b7dbaecb4e0E" = unnamed_addr alias void (%"unix::linux_like::linux::passwd"*, %"unix::linux_like::linux::passwd"*), bitcast (void (%"unix::linux_like::addrinfo"*, %"unix::linux_like::addrinfo"*)* @"_ZN71_$LT$libc..unix..linux_like..addrinfo$u20$as$u20$core..clone..Clone$GT$5clone17h0685a4853c93ab20E" to void (%"unix::linux_like::linux::passwd"*, %"unix::linux_like::linux::passwd"*)*)
@"_ZN76_$LT$libc..unix..linux_like..linux..glob_t$u20$as$u20$core..clone..Clone$GT$5clone17he5927fca6c3fe302E" = unnamed_addr alias void (%"unix::linux_like::linux::glob_t"*, %"unix::linux_like::linux::glob_t"*), bitcast (void (%"unix::linux_like::linux::spwd"*, %"unix::linux_like::linux::spwd"*)* @"_ZN74_$LT$libc..unix..linux_like..linux..spwd$u20$as$u20$core..clone..Clone$GT$5clone17hb18d8245fe22545bE" to void (%"unix::linux_like::linux::glob_t"*, %"unix::linux_like::linux::glob_t"*)*)
@"_ZN75_$LT$libc..unix..linux_like..linux..dqblk$u20$as$u20$core..clone..Clone$GT$5clone17hf37907c842e723b0E" = unnamed_addr alias void (%"unix::linux_like::linux::dqblk"*, %"unix::linux_like::linux::dqblk"*), bitcast (void (%"unix::linux_like::linux::spwd"*, %"unix::linux_like::linux::spwd"*)* @"_ZN74_$LT$libc..unix..linux_like..linux..spwd$u20$as$u20$core..clone..Clone$GT$5clone17hb18d8245fe22545bE" to void (%"unix::linux_like::linux::dqblk"*, %"unix::linux_like::linux::dqblk"*)*)
@"_ZN86_$LT$libc..unix..linux_like..linux..signalfd_siginfo$u20$as$u20$core..clone..Clone$GT$5clone17hf1c7a9b2196e5410E" = unnamed_addr alias void (%"unix::linux_like::linux::signalfd_siginfo"*, %"unix::linux_like::linux::signalfd_siginfo"*), bitcast (void (%"unix::linux_like::fd_set"*, %"unix::linux_like::fd_set"*)* @"_ZN69_$LT$libc..unix..linux_like..fd_set$u20$as$u20$core..clone..Clone$GT$5clone17h6589b1322586f879E" to void (%"unix::linux_like::linux::signalfd_siginfo"*, %"unix::linux_like::linux::signalfd_siginfo"*)*)
@"_ZN80_$LT$libc..unix..linux_like..linux..itimerspec$u20$as$u20$core..clone..Clone$GT$5clone17hca2bf428f2eb2bd6E" = unnamed_addr alias void (%"unix::linux_like::linux::itimerspec"*, %"unix::linux_like::linux::itimerspec"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::linux_like::linux::itimerspec"*, %"unix::linux_like::linux::itimerspec"*)*)
@"_ZN79_$LT$libc..unix..linux_like..linux..cpu_set_t$u20$as$u20$core..clone..Clone$GT$5clone17hdefc56c530250093E" = unnamed_addr alias void (%"unix::linux_like::linux::cpu_set_t"*, %"unix::linux_like::linux::cpu_set_t"*), bitcast (void (%"unix::linux_like::fd_set"*, %"unix::linux_like::fd_set"*)* @"_ZN69_$LT$libc..unix..linux_like..fd_set$u20$as$u20$core..clone..Clone$GT$5clone17h6589b1322586f879E" to void (%"unix::linux_like::linux::cpu_set_t"*, %"unix::linux_like::linux::cpu_set_t"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..input_event$u20$as$u20$core..clone..Clone$GT$5clone17h220e2d029fac6fb3E" = unnamed_addr alias void (%"unix::linux_like::linux::input_event"*, %"unix::linux_like::linux::input_event"*), bitcast (void (%"unix::protoent"*, %"unix::protoent"*)* @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E" to void (%"unix::linux_like::linux::input_event"*, %"unix::linux_like::linux::input_event"*)*)
@"_ZN88_$LT$libc..unix..linux_like..linux..ff_periodic_effect$u20$as$u20$core..clone..Clone$GT$5clone17h1c7646972f4e38c7E" = unnamed_addr alias void (%"unix::linux_like::linux::ff_periodic_effect"*, %"unix::linux_like::linux::ff_periodic_effect"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::linux_like::linux::ff_periodic_effect"*, %"unix::linux_like::linux::ff_periodic_effect"*)*)
@"_ZN79_$LT$libc..unix..linux_like..linux..ff_effect$u20$as$u20$core..clone..Clone$GT$5clone17h2ce60b26ebbdad05E" = unnamed_addr alias void (%"unix::linux_like::linux::ff_effect"*, %"unix::linux_like::linux::ff_effect"*), bitcast (void (%"unix::linux_like::addrinfo"*, %"unix::linux_like::addrinfo"*)* @"_ZN71_$LT$libc..unix..linux_like..addrinfo$u20$as$u20$core..clone..Clone$GT$5clone17h0685a4853c93ab20E" to void (%"unix::linux_like::linux::ff_effect"*, %"unix::linux_like::linux::ff_effect"*)*)
@"_ZN86_$LT$libc..unix..linux_like..linux..uinput_abs_setup$u20$as$u20$core..clone..Clone$GT$5clone17hd2e7e50338379828E" = unnamed_addr alias void (%"unix::linux_like::linux::uinput_abs_setup"*, %"unix::linux_like::linux::uinput_abs_setup"*), bitcast (void (%"unix::linux_like::sockaddr_in6"*, %"unix::linux_like::sockaddr_in6"*)* @"_ZN75_$LT$libc..unix..linux_like..sockaddr_in6$u20$as$u20$core..clone..Clone$GT$5clone17hb27d2f1e175f63d7E" to void (%"unix::linux_like::linux::uinput_abs_setup"*, %"unix::linux_like::linux::uinput_abs_setup"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..dl_phdr_info$u20$as$u20$core..clone..Clone$GT$5clone17h6b55b1679affcf9aE" = unnamed_addr alias void (%"unix::linux_like::linux::dl_phdr_info"*, %"unix::linux_like::linux::dl_phdr_info"*), bitcast (void (%"unix::linux_like::mmsghdr"*, %"unix::linux_like::mmsghdr"*)* @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE" to void (%"unix::linux_like::linux::dl_phdr_info"*, %"unix::linux_like::linux::dl_phdr_info"*)*)
@"_ZN79_$LT$libc..unix..linux_like..linux..Elf64_Sym$u20$as$u20$core..clone..Clone$GT$5clone17hb5ba5fbb2270c697E" = unnamed_addr alias void (%"unix::linux_like::linux::Elf64_Sym"*, %"unix::linux_like::linux::Elf64_Sym"*), bitcast (void (%"unix::protoent"*, %"unix::protoent"*)* @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E" to void (%"unix::linux_like::linux::Elf64_Sym"*, %"unix::linux_like::linux::Elf64_Sym"*)*)
@"_ZN80_$LT$libc..unix..linux_like..linux..Elf32_Phdr$u20$as$u20$core..clone..Clone$GT$5clone17h895314b0d9344cf4E" = unnamed_addr alias void (%"unix::linux_like::linux::Elf32_Phdr"*, %"unix::linux_like::linux::Elf32_Phdr"*), bitcast (void (%"unix::linux_like::linux::msginfo"*, %"unix::linux_like::linux::msginfo"*)* @"_ZN77_$LT$libc..unix..linux_like..linux..msginfo$u20$as$u20$core..clone..Clone$GT$5clone17he0213bb3c85451f0E" to void (%"unix::linux_like::linux::Elf32_Phdr"*, %"unix::linux_like::linux::Elf32_Phdr"*)*)
@"_ZN80_$LT$libc..unix..linux_like..linux..Elf64_Phdr$u20$as$u20$core..clone..Clone$GT$5clone17haa3d6861de8966c6E" = unnamed_addr alias void (%"unix::linux_like::linux::Elf64_Phdr"*, %"unix::linux_like::linux::Elf64_Phdr"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..pthread_attr_t$u20$as$u20$core..clone..Clone$GT$5clone17h22da86904259d03fE" to void (%"unix::linux_like::linux::Elf64_Phdr"*, %"unix::linux_like::linux::Elf64_Phdr"*)*)
@"_ZN80_$LT$libc..unix..linux_like..linux..Elf64_Shdr$u20$as$u20$core..clone..Clone$GT$5clone17hdf43d5d8f77e6e71E" = unnamed_addr alias void (%"unix::linux_like::linux::Elf64_Shdr"*, %"unix::linux_like::linux::Elf64_Shdr"*), bitcast (void (%"unix::linux_like::mmsghdr"*, %"unix::linux_like::mmsghdr"*)* @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE" to void (%"unix::linux_like::linux::Elf64_Shdr"*, %"unix::linux_like::linux::Elf64_Shdr"*)*)
@"_ZN96_$LT$libc..unix..linux_like..linux..posix_spawn_file_actions_t$u20$as$u20$core..clone..Clone$GT$5clone17h4d30c319fe33a64cE" = unnamed_addr alias void (%"unix::linux_like::linux::posix_spawn_file_actions_t"*, %"unix::linux_like::linux::posix_spawn_file_actions_t"*), bitcast (void (%"unix::linux_like::in6_rtmsg"*, %"unix::linux_like::in6_rtmsg"*)* @"_ZN72_$LT$libc..unix..linux_like..in6_rtmsg$u20$as$u20$core..clone..Clone$GT$5clone17h997b051f352c15e8E" to void (%"unix::linux_like::linux::posix_spawn_file_actions_t"*, %"unix::linux_like::linux::posix_spawn_file_actions_t"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..in6_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17h3ad96d12cbdb6a5dE" = unnamed_addr alias void (%"unix::linux_like::linux::in6_pktinfo"*, %"unix::linux_like::linux::in6_pktinfo"*), bitcast (void (%"unix::ipv6_mreq"*, %"unix::ipv6_mreq"*)* @"_ZN60_$LT$libc..unix..ipv6_mreq$u20$as$u20$core..clone..Clone$GT$5clone17h3f43912004402d0aE" to void (%"unix::linux_like::linux::in6_pktinfo"*, %"unix::linux_like::linux::in6_pktinfo"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..arpd_request$u20$as$u20$core..clone..Clone$GT$5clone17h0f324eb178466cc3E" = unnamed_addr alias void (%"unix::linux_like::linux::arpd_request"*, %"unix::linux_like::linux::arpd_request"*), bitcast (void (%"unix::linux_like::linux::mntent"*, %"unix::linux_like::linux::mntent"*)* @"_ZN76_$LT$libc..unix..linux_like..linux..mntent$u20$as$u20$core..clone..Clone$GT$5clone17h9fde77384649b643E" to void (%"unix::linux_like::linux::arpd_request"*, %"unix::linux_like::linux::arpd_request"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..seccomp_data$u20$as$u20$core..clone..Clone$GT$5clone17hc803901a22cc9dfcE" = unnamed_addr alias void (%"unix::linux_like::linux::seccomp_data"*, %"unix::linux_like::linux::seccomp_data"*), bitcast (void (%"unix::linux_like::mmsghdr"*, %"unix::linux_like::mmsghdr"*)* @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE" to void (%"unix::linux_like::linux::seccomp_data"*, %"unix::linux_like::linux::seccomp_data"*)*)
@"_ZN78_$LT$libc..unix..linux_like..linux..nlmsgerr$u20$as$u20$core..clone..Clone$GT$5clone17h293dc26c644be9c3E" = unnamed_addr alias void (%"unix::linux_like::linux::nlmsgerr"*, %"unix::linux_like::linux::nlmsgerr"*), bitcast (void (%"unix::ipv6_mreq"*, %"unix::ipv6_mreq"*)* @"_ZN60_$LT$libc..unix..ipv6_mreq$u20$as$u20$core..clone..Clone$GT$5clone17h3f43912004402d0aE" to void (%"unix::linux_like::linux::nlmsgerr"*, %"unix::linux_like::linux::nlmsgerr"*)*)
@"_ZN78_$LT$libc..unix..linux_like..linux..dirent64$u20$as$u20$core..clone..Clone$GT$5clone17he4c7b2c8825c40cfE" = unnamed_addr alias void (%"unix::linux_like::linux::dirent64"*, %"unix::linux_like::linux::dirent64"*), bitcast (void (%"unix::linux_like::linux::dirent"*, %"unix::linux_like::linux::dirent"*)* @"_ZN76_$LT$libc..unix..linux_like..linux..dirent$u20$as$u20$core..clone..Clone$GT$5clone17h79615945466cf71dE" to void (%"unix::linux_like::linux::dirent64"*, %"unix::linux_like::linux::dirent64"*)*)
@"_ZN77_$LT$libc..unix..linux_like..linux..mq_attr$u20$as$u20$core..clone..Clone$GT$5clone17heee7a67f1e47e5b5E" = unnamed_addr alias void (%"unix::linux_like::linux::mq_attr"*, %"unix::linux_like::linux::mq_attr"*), bitcast (void (%"unix::linux_like::mmsghdr"*, %"unix::linux_like::mmsghdr"*)* @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE" to void (%"unix::linux_like::linux::mq_attr"*, %"unix::linux_like::linux::mq_attr"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..sockaddr_can$u20$as$u20$core..clone..Clone$GT$5clone17hf8a57b21b9d7c14aE" = unnamed_addr alias void (%"unix::linux_like::linux::sockaddr_can"*, %"unix::linux_like::linux::sockaddr_can"*), bitcast (void (%"unix::protoent"*, %"unix::protoent"*)* @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E" to void (%"unix::linux_like::linux::sockaddr_can"*, %"unix::linux_like::linux::sockaddr_can"*)*)
@"_ZN83_$LT$libc..unix..linux_like..linux..gnu..glob64_t$u20$as$u20$core..clone..Clone$GT$5clone17haa73f40bd101a69aE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::glob64_t"*, %"unix::linux_like::linux::gnu::glob64_t"*), bitcast (void (%"unix::linux_like::linux::spwd"*, %"unix::linux_like::linux::spwd"*)* @"_ZN74_$LT$libc..unix..linux_like..linux..spwd$u20$as$u20$core..clone..Clone$GT$5clone17hb18d8245fe22545bE" to void (%"unix::linux_like::linux::gnu::glob64_t"*, %"unix::linux_like::linux::gnu::glob64_t"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..gnu..msghdr$u20$as$u20$core..clone..Clone$GT$5clone17ha8386c6a6680c60fE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::msghdr"*, %"unix::linux_like::linux::gnu::msghdr"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..pthread_attr_t$u20$as$u20$core..clone..Clone$GT$5clone17h22da86904259d03fE" to void (%"unix::linux_like::linux::gnu::msghdr"*, %"unix::linux_like::linux::gnu::msghdr"*)*)
@"_ZN83_$LT$libc..unix..linux_like..linux..gnu..mallinfo$u20$as$u20$core..clone..Clone$GT$5clone17h0982c74c27bfd01cE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::mallinfo"*, %"unix::linux_like::linux::gnu::mallinfo"*), bitcast (void (%"unix::linux_like::linux::Elf32_Shdr"*, %"unix::linux_like::linux::Elf32_Shdr"*)* @"_ZN80_$LT$libc..unix..linux_like..linux..Elf32_Shdr$u20$as$u20$core..clone..Clone$GT$5clone17h96cb0be33d1d2b2bE" to void (%"unix::linux_like::linux::gnu::mallinfo"*, %"unix::linux_like::linux::gnu::mallinfo"*)*)
@"_ZN84_$LT$libc..unix..linux_like..linux..gnu..mallinfo2$u20$as$u20$core..clone..Clone$GT$5clone17h4fc9935fcefdd02eE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::mallinfo2"*, %"unix::linux_like::linux::gnu::mallinfo2"*), bitcast (void (%"unix::linux_like::in6_rtmsg"*, %"unix::linux_like::in6_rtmsg"*)* @"_ZN72_$LT$libc..unix..linux_like..in6_rtmsg$u20$as$u20$core..clone..Clone$GT$5clone17h997b051f352c15e8E" to void (%"unix::linux_like::linux::gnu::mallinfo2"*, %"unix::linux_like::linux::gnu::mallinfo2"*)*)
@"_ZN86_$LT$libc..unix..linux_like..linux..gnu..nl_mmap_hdr$u20$as$u20$core..clone..Clone$GT$5clone17h2ce22bdb1f01dc42E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::nl_mmap_hdr"*, %"unix::linux_like::linux::gnu::nl_mmap_hdr"*), bitcast (void (%"unix::linux_like::linux::input_absinfo"*, %"unix::linux_like::linux::input_absinfo"*)* @"_ZN83_$LT$libc..unix..linux_like..linux..input_absinfo$u20$as$u20$core..clone..Clone$GT$5clone17hba9dfac0d14dd3ccE" to void (%"unix::linux_like::linux::gnu::nl_mmap_hdr"*, %"unix::linux_like::linux::gnu::nl_mmap_hdr"*)*)
@"_ZN85_$LT$libc..unix..linux_like..linux..gnu..ntptimeval$u20$as$u20$core..clone..Clone$GT$5clone17h4ca22a4d62cc0a42E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::ntptimeval"*, %"unix::linux_like::linux::gnu::ntptimeval"*), bitcast (void (%"unix::linux_like::linux::spwd"*, %"unix::linux_like::linux::spwd"*)* @"_ZN74_$LT$libc..unix..linux_like..linux..spwd$u20$as$u20$core..clone..Clone$GT$5clone17hb18d8245fe22545bE" to void (%"unix::linux_like::linux::gnu::ntptimeval"*, %"unix::linux_like::linux::gnu::ntptimeval"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..gnu..regex_t$u20$as$u20$core..clone..Clone$GT$5clone17he9155f24fb1c6363E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::regex_t"*, %"unix::linux_like::linux::gnu::regex_t"*), bitcast (void (%"unix::linux_like::mmsghdr"*, %"unix::linux_like::mmsghdr"*)* @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE" to void (%"unix::linux_like::linux::gnu::regex_t"*, %"unix::linux_like::linux::gnu::regex_t"*)*)
@"_ZN85_$LT$libc..unix..linux_like..linux..gnu..Elf64_Chdr$u20$as$u20$core..clone..Clone$GT$5clone17h18437b88de5ca28fE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::Elf64_Chdr"*, %"unix::linux_like::linux::gnu::Elf64_Chdr"*), bitcast (void (%"unix::protoent"*, %"unix::protoent"*)* @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E" to void (%"unix::linux_like::linux::gnu::Elf64_Chdr"*, %"unix::linux_like::linux::gnu::Elf64_Chdr"*)*)
@"_ZN82_$LT$libc..unix..linux_like..linux..gnu..seminfo$u20$as$u20$core..clone..Clone$GT$5clone17h0f62df666b42c887E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::seminfo"*, %"unix::linux_like::linux::gnu::seminfo"*), bitcast (void (%"unix::linux_like::linux::Elf32_Shdr"*, %"unix::linux_like::linux::Elf32_Shdr"*)* @"_ZN80_$LT$libc..unix..linux_like..linux..Elf32_Shdr$u20$as$u20$core..clone..Clone$GT$5clone17h96cb0be33d1d2b2bE" to void (%"unix::linux_like::linux::gnu::seminfo"*, %"unix::linux_like::linux::gnu::seminfo"*)*)
@"_ZN91_$LT$libc..unix..linux_like..linux..gnu..sifields_sigchld$u20$as$u20$core..clone..Clone$GT$5clone17h093c11fbf5f80334E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::sifields_sigchld"*, %"unix::linux_like::linux::gnu::sifields_sigchld"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::linux_like::linux::gnu::sifields_sigchld"*, %"unix::linux_like::linux::gnu::sifields_sigchld"*)*)
@"_ZN88_$LT$libc..unix..linux_like..linux..gnu..b64..sigset_t$u20$as$u20$core..clone..Clone$GT$5clone17h1bf3bf8dc8fd430dE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::sigset_t"*, %"unix::linux_like::linux::gnu::b64::sigset_t"*), bitcast (void (%"unix::linux_like::fd_set"*, %"unix::linux_like::fd_set"*)* @"_ZN69_$LT$libc..unix..linux_like..fd_set$u20$as$u20$core..clone..Clone$GT$5clone17h6589b1322586f879E" to void (%"unix::linux_like::linux::gnu::b64::sigset_t"*, %"unix::linux_like::linux::gnu::b64::sigset_t"*)*)
@"_ZN88_$LT$libc..unix..linux_like..linux..gnu..b64..msqid_ds$u20$as$u20$core..clone..Clone$GT$5clone17hcd66e522c3469597E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::msqid_ds"*, %"unix::linux_like::linux::gnu::b64::msqid_ds"*), bitcast (void (%"unix::linux_like::linux::gnu::rtentry"*, %"unix::linux_like::linux::gnu::rtentry"*)* @"_ZN82_$LT$libc..unix..linux_like..linux..gnu..rtentry$u20$as$u20$core..clone..Clone$GT$5clone17hd08bb9c8a0fa1ebfE" to void (%"unix::linux_like::linux::gnu::b64::msqid_ds"*, %"unix::linux_like::linux::gnu::b64::msqid_ds"*)*)
@"_ZN88_$LT$libc..unix..linux_like..linux..gnu..b64..semid_ds$u20$as$u20$core..clone..Clone$GT$5clone17h5cbf836fe16abd2eE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::semid_ds"*, %"unix::linux_like::linux::gnu::b64::semid_ds"*), bitcast (void (%"unix::linux_like::linux::uinput_ff_upload"*, %"unix::linux_like::linux::uinput_ff_upload"*)* @"_ZN86_$LT$libc..unix..linux_like..linux..uinput_ff_upload$u20$as$u20$core..clone..Clone$GT$5clone17hf5f4429594e84b2fE" to void (%"unix::linux_like::linux::gnu::b64::semid_ds"*, %"unix::linux_like::linux::gnu::b64::semid_ds"*)*)
@"_ZN94_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..statfs$u20$as$u20$core..clone..Clone$GT$5clone17h61dbd82e06108f66E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::statfs"*, %"unix::linux_like::linux::gnu::b64::x86_64::statfs"*), bitcast (void (%"unix::linux_like::linux::gnu::rtentry"*, %"unix::linux_like::linux::gnu::rtentry"*)* @"_ZN82_$LT$libc..unix..linux_like..linux..gnu..rtentry$u20$as$u20$core..clone..Clone$GT$5clone17hd08bb9c8a0fa1ebfE" to void (%"unix::linux_like::linux::gnu::b64::x86_64::statfs"*, %"unix::linux_like::linux::gnu::b64::x86_64::statfs"*)*)
@"_ZN93_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..flock$u20$as$u20$core..clone..Clone$GT$5clone17h291d57ba2a61f4bcE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::flock"*, %"unix::linux_like::linux::gnu::b64::x86_64::flock"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::flock"*, %"unix::linux_like::linux::gnu::b64::x86_64::flock"*)*)
@"_ZN95_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..flock64$u20$as$u20$core..clone..Clone$GT$5clone17h989e5b3f9f94a757E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::flock64"*, %"unix::linux_like::linux::gnu::b64::x86_64::flock64"*), bitcast (void (%"unix::tms"*, %"unix::tms"*)* @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::flock64"*, %"unix::linux_like::linux::gnu::b64::x86_64::flock64"*)*)
@"_ZN97_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$u20$as$u20$core..clone..Clone$GT$5clone17hc3f2bd3ae18f7652E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"*), bitcast (void (%"unix::linux_like::fd_set"*, %"unix::linux_like::fd_set"*)* @"_ZN69_$LT$libc..unix..linux_like..fd_set$u20$as$u20$core..clone..Clone$GT$5clone17h6589b1322586f879E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"*)*)
@"_ZN95_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..stack_t$u20$as$u20$core..clone..Clone$GT$5clone17hc398c7faec96eec1E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::stack_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::stack_t"*), bitcast (void (%"unix::protoent"*, %"unix::protoent"*)* @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::stack_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::stack_t"*)*)
@"_ZN92_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..stat$u20$as$u20$core..clone..Clone$GT$5clone17hbcdf196be82c33ffE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::stat"*, %"unix::linux_like::linux::gnu::b64::x86_64::stat"*), bitcast (void (%"unix::rusage"*, %"unix::rusage"*)* @"_ZN57_$LT$libc..unix..rusage$u20$as$u20$core..clone..Clone$GT$5clone17h6e4e8512e12e7f5eE" to void (%"unix::linux_like::linux::gnu::b64::x86_64::stat"*, %"unix::linux_like::linux::gnu::b64::x86_64::stat"*)*)
@"_ZN94_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..stat64$u20$as$u20$core..clone..Clone$GT$5clone17ha2f0ecb94d4d2dd6E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::stat64"*, %"unix::linux_like::linux::gnu::b64::x86_64::stat64"*), bitcast (void (%"unix::rusage"*, %"unix::rusage"*)* @"_ZN57_$LT$libc..unix..rusage$u20$as$u20$core..clone..Clone$GT$5clone17h6e4e8512e12e7f5eE" to void (%"unix::linux_like::linux::gnu::b64::x86_64::stat64"*, %"unix::linux_like::linux::gnu::b64::x86_64::stat64"*)*)
@"_ZN96_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..statfs64$u20$as$u20$core..clone..Clone$GT$5clone17h8bef1f67f80e0443E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::statfs64"*, %"unix::linux_like::linux::gnu::b64::x86_64::statfs64"*), bitcast (void (%"unix::linux_like::linux::gnu::rtentry"*, %"unix::linux_like::linux::gnu::rtentry"*)* @"_ZN82_$LT$libc..unix..linux_like..linux..gnu..rtentry$u20$as$u20$core..clone..Clone$GT$5clone17hd08bb9c8a0fa1ebfE" to void (%"unix::linux_like::linux::gnu::b64::x86_64::statfs64"*, %"unix::linux_like::linux::gnu::b64::x86_64::statfs64"*)*)
@"_ZN97_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..statvfs64$u20$as$u20$core..clone..Clone$GT$5clone17h51980ca3ef4987aeE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::statvfs64"*, %"unix::linux_like::linux::gnu::b64::x86_64::statvfs64"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"*, %"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"*)* @"_ZN104_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..not_x32..statvfs$u20$as$u20$core..clone..Clone$GT$5clone17hf9db3cfcc68b9c03E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::statvfs64"*, %"unix::linux_like::linux::gnu::b64::x86_64::statvfs64"*)*)
@"_ZN65_$LT$libc..unix..linux_like..tm$u20$as$u20$core..clone..Clone$GT$5clone17hbcd943b5379d3163E" = unnamed_addr alias void (%"unix::linux_like::tm"*, %"unix::linux_like::tm"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"*)* @"_ZN102_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..pthread_attr_t$u20$as$u20$core..clone..Clone$GT$5clone17h22da86904259d03fE" to void (%"unix::linux_like::tm"*, %"unix::linux_like::tm"*)*)
@"_ZN98_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..mcontext_t$u20$as$u20$core..clone..Clone$GT$5clone17ha775082b8f57412aE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::mcontext_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::mcontext_t"*), bitcast (void (%"unix::linux_like::linux::gnu::statx"*, %"unix::linux_like::linux::gnu::statx"*)* @"_ZN80_$LT$libc..unix..linux_like..linux..gnu..statx$u20$as$u20$core..clone..Clone$GT$5clone17h9b305f1591ba7d3cE" to void (%"unix::linux_like::linux::gnu::b64::x86_64::mcontext_t"*, %"unix::linux_like::linux::gnu::b64::x86_64::mcontext_t"*)*)
@"_ZN96_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..ipc_perm$u20$as$u20$core..clone..Clone$GT$5clone17h7e1364669a7bc41dE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm"*, %"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm"*), bitcast (void (%"unix::linux_like::addrinfo"*, %"unix::linux_like::addrinfo"*)* @"_ZN71_$LT$libc..unix..linux_like..addrinfo$u20$as$u20$core..clone..Clone$GT$5clone17h0685a4853c93ab20E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm"*, %"unix::linux_like::linux::gnu::b64::x86_64::ipc_perm"*)*)
@"_ZN96_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..shmid_ds$u20$as$u20$core..clone..Clone$GT$5clone17h37cb18697df4584bE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::shmid_ds"*, %"unix::linux_like::linux::gnu::b64::x86_64::shmid_ds"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"*, %"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"*)* @"_ZN104_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..not_x32..statvfs$u20$as$u20$core..clone..Clone$GT$5clone17hf9db3cfcc68b9c03E" to void (%"unix::linux_like::linux::gnu::b64::x86_64::shmid_ds"*, %"unix::linux_like::linux::gnu::b64::x86_64::shmid_ds"*)*)
@"_ZN106_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..user_fpregs_struct$u20$as$u20$core..clone..Clone$GT$5clone17hdbc48d9be93d0453E" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct"*, %"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"*, %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"*)* @"_ZN101_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_fpstate$u20$as$u20$core..clone..Clone$GT$5clone17h7a8d74b8426e4d5aE" to void (%"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct"*, %"unix::linux_like::linux::gnu::b64::x86_64::user_fpregs_struct"*)*)
@"_ZN87_$LT$libc..unix..linux_like..linux..gnu..b64..sysinfo$u20$as$u20$core..clone..Clone$GT$5clone17ha14465aebd2fd70eE" = unnamed_addr alias void (%"unix::linux_like::linux::gnu::b64::sysinfo"*, %"unix::linux_like::linux::gnu::b64::sysinfo"*), bitcast (void (%"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"*, %"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"*)* @"_ZN104_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..not_x32..statvfs$u20$as$u20$core..clone..Clone$GT$5clone17hf9db3cfcc68b9c03E" to void (%"unix::linux_like::linux::gnu::b64::sysinfo"*, %"unix::linux_like::linux::gnu::b64::sysinfo"*)*)
@"_ZN93_$LT$libc..unix..linux_like..linux..fanotify_event_metadata$u20$as$u20$core..clone..Clone$GT$5clone17h209a0370627f80d2E" = unnamed_addr alias void (%"unix::linux_like::linux::fanotify_event_metadata"*, %"unix::linux_like::linux::fanotify_event_metadata"*), bitcast (void (%"unix::protoent"*, %"unix::protoent"*)* @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E" to void (%"unix::linux_like::linux::fanotify_event_metadata"*, %"unix::linux_like::linux::fanotify_event_metadata"*)*)
@"_ZN81_$LT$libc..unix..linux_like..linux..canfd_frame$u20$as$u20$core..clone..Clone$GT$5clone17h2ed7b4074430df10E" = unnamed_addr alias void (%"unix::linux_like::linux::canfd_frame"*, %"unix::linux_like::linux::canfd_frame"*), bitcast (void (%"unix::linux_like::linux::spwd"*, %"unix::linux_like::linux::spwd"*)* @"_ZN74_$LT$libc..unix..linux_like..linux..spwd$u20$as$u20$core..clone..Clone$GT$5clone17hb18d8245fe22545bE" to void (%"unix::linux_like::linux::canfd_frame"*, %"unix::linux_like::linux::canfd_frame"*)*)
@"_ZN55_$LT$libc..unix..FILE$u20$as$u20$core..clone..Clone$GT$5clone17hc6b34619b83580f6E" = unnamed_addr alias void (%"unix::FILE"*), bitcast (void (%"unix::DIR"*)* @"_ZN54_$LT$libc..unix..DIR$u20$as$u20$core..clone..Clone$GT$5clone17h6acd43721e648d57E" to void (%"unix::FILE"*)*)
@"_ZN57_$LT$libc..unix..fpos_t$u20$as$u20$core..clone..Clone$GT$5clone17h4681a1b56401ce0aE" = unnamed_addr alias void (%"unix::fpos_t"*), bitcast (void (%"unix::DIR"*)* @"_ZN54_$LT$libc..unix..DIR$u20$as$u20$core..clone..Clone$GT$5clone17h6acd43721e648d57E" to void (%"unix::fpos_t"*)*)
@"_ZN71_$LT$libc..unix..linux_like..timezone$u20$as$u20$core..clone..Clone$GT$5clone17h95d10637e1a76a85E" = unnamed_addr alias void (%"unix::linux_like::timezone"*), bitcast (void (%"unix::DIR"*)* @"_ZN54_$LT$libc..unix..DIR$u20$as$u20$core..clone..Clone$GT$5clone17h6acd43721e648d57E" to void (%"unix::linux_like::timezone"*)*)
@"_ZN78_$LT$libc..unix..linux_like..linux..fpos64_t$u20$as$u20$core..clone..Clone$GT$5clone17h2aff6a057c8b6cb7E" = unnamed_addr alias void (%"unix::linux_like::linux::fpos64_t"*), bitcast (void (%"unix::DIR"*)* @"_ZN54_$LT$libc..unix..DIR$u20$as$u20$core..clone..Clone$GT$5clone17h6acd43721e648d57E" to void (%"unix::linux_like::linux::fpos64_t"*)*)
@"_ZN58_$LT$libc..unix..utimbuf$u20$as$u20$core..clone..Clone$GT$5clone17h06c26bf70fb11eb0E" = unnamed_addr alias { i64, i64 } ({ i64, i64 }*), bitcast ({ i8*, i64 } ({ i8*, i64 }*)* @"_ZN56_$LT$libc..unix..iovec$u20$as$u20$core..clone..Clone$GT$5clone17hd82ebe32063b9832E" to { i64, i64 } ({ i64, i64 }*)*)
@"_ZN59_$LT$libc..unix..timespec$u20$as$u20$core..clone..Clone$GT$5clone17h5d67701897878866E" = unnamed_addr alias { i64, i64 } ({ i64, i64 }*), bitcast ({ i8*, i64 } ({ i8*, i64 }*)* @"_ZN56_$LT$libc..unix..iovec$u20$as$u20$core..clone..Clone$GT$5clone17hd82ebe32063b9832E" to { i64, i64 } ({ i64, i64 }*)*)
@"_ZN58_$LT$libc..unix..timeval$u20$as$u20$core..clone..Clone$GT$5clone17h2418fc1ef754728bE" = unnamed_addr alias { i64, i64 } ({ i64, i64 }*), bitcast ({ i8*, i64 } ({ i8*, i64 }*)* @"_ZN56_$LT$libc..unix..iovec$u20$as$u20$core..clone..Clone$GT$5clone17hd82ebe32063b9832E" to { i64, i64 } ({ i64, i64 }*)*)
@"_ZN57_$LT$libc..unix..rlimit$u20$as$u20$core..clone..Clone$GT$5clone17haa27e5422384d6c8E" = unnamed_addr alias { i64, i64 } ({ i64, i64 }*), bitcast ({ i8*, i64 } ({ i8*, i64 }*)* @"_ZN56_$LT$libc..unix..iovec$u20$as$u20$core..clone..Clone$GT$5clone17hd82ebe32063b9832E" to { i64, i64 } ({ i64, i64 }*)*)
@"_ZN78_$LT$libc..unix..linux_like..linux..rlimit64$u20$as$u20$core..clone..Clone$GT$5clone17h4a12f2c9a2204bddE" = unnamed_addr alias { i64, i64 } ({ i64, i64 }*), bitcast ({ i8*, i64 } ({ i8*, i64 }*)* @"_ZN56_$LT$libc..unix..iovec$u20$as$u20$core..clone..Clone$GT$5clone17hd82ebe32063b9832E" to { i64, i64 } ({ i64, i64 }*)*)
@"_ZN80_$LT$libc..unix..linux_like..linux..ff_trigger$u20$as$u20$core..clone..Clone$GT$5clone17hb925910ada9d3225E" = unnamed_addr alias { i16, i16 } ({ i16, i16 }*), { i16, i16 } ({ i16, i16 }*)* @"_ZN76_$LT$libc..unix..linux_like..linux..nlattr$u20$as$u20$core..clone..Clone$GT$5clone17hdf7506b097368518E"
@"_ZN86_$LT$libc..unix..linux_like..linux..ff_rumble_effect$u20$as$u20$core..clone..Clone$GT$5clone17h6672aa2e7d23c6e4E" = unnamed_addr alias { i16, i16 } ({ i16, i16 }*), { i16, i16 } ({ i16, i16 }*)* @"_ZN76_$LT$libc..unix..linux_like..linux..nlattr$u20$as$u20$core..clone..Clone$GT$5clone17hdf7506b097368518E"
@"_ZN87_$LT$libc..unix..linux_like..linux..fanotify_response$u20$as$u20$core..clone..Clone$GT$5clone17h3a714fb478ae4cd8E" = unnamed_addr alias { i32, i32 } ({ i32, i32 }*), { i32, i32 } ({ i32, i32 }*)* @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"
@"_ZN80_$LT$libc..unix..linux_like..linux..regmatch_t$u20$as$u20$core..clone..Clone$GT$5clone17h1df84e2b7c8217feE" = unnamed_addr alias { i32, i32 } ({ i32, i32 }*), { i32, i32 } ({ i32, i32 }*)* @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"
@"_ZN99_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_tp$u20$as$u20$core..clone..Clone$GT$5clone17h0462d0ce7ce3702fE" = unnamed_addr alias { i32, i32 } ({ i32, i32 }*), { i32, i32 } ({ i32, i32 }*)* @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"
@"_ZN80_$LT$libc..unix..linux_like..linux..can_filter$u20$as$u20$core..clone..Clone$GT$5clone17hf06873167a90e07bE" = unnamed_addr alias { i32, i32 } ({ i32, i32 }*), { i32, i32 } ({ i32, i32 }*)* @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"
@"_ZN79_$LT$libc..unix..linux_like..linux..ff_replay$u20$as$u20$core..clone..Clone$GT$5clone17h8d749c36d942f42cE" = unnamed_addr alias { i16, i16 } ({ i16, i16 }*), { i16, i16 } ({ i16, i16 }*)* @"_ZN76_$LT$libc..unix..linux_like..linux..nlattr$u20$as$u20$core..clone..Clone$GT$5clone17hdf7506b097368518E"
@"_ZN81_$LT$libc..unix..linux_like..linux..sock_txtime$u20$as$u20$core..clone..Clone$GT$5clone17h22248c52dd13daabE" = unnamed_addr alias { i32, i32 } ({ i32, i32 }*), { i32, i32 } ({ i32, i32 }*)* @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"
@"_ZN88_$LT$libc..unix..linux_like..linux..gnu..__exit_status$u20$as$u20$core..clone..Clone$GT$5clone17h016a0d733d338383E" = unnamed_addr alias { i16, i16 } ({ i16, i16 }*), { i16, i16 } ({ i16, i16 }*)* @"_ZN76_$LT$libc..unix..linux_like..linux..nlattr$u20$as$u20$core..clone..Clone$GT$5clone17hdf7506b097368518E"
@"_ZN84_$LT$libc..unix..linux_like..linux..gnu..__timeval$u20$as$u20$core..clone..Clone$GT$5clone17hd7bb1c6e0a3e6f8cE" = unnamed_addr alias { i32, i32 } ({ i32, i32 }*), { i32, i32 } ({ i32, i32 }*)* @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"

; Function Attrs: noreturn nounwind nonlazybind uwtable
define void @"_ZN54_$LT$libc..unix..DIR$u20$as$u20$core..clone..Clone$GT$5clone17h6acd43721e648d57E"(%"unix::DIR"* mpk_immut noalias nocapture nonnull readonly align 1 %self) unnamed_addr #0 {
start:
  tail call void @llvm.trap()
  unreachable
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN57_$LT$libc..unix..rusage$u20$as$u20$core..clone..Clone$GT$5clone17h6e4e8512e12e7f5eE"(%"unix::rusage"* noalias nocapture sret dereferenceable(144) %0, %"unix::rusage"* mpk_immut noalias nocapture readonly align 8 dereferenceable(144) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::rusage"* %0 to i8*
  %2 = bitcast %"unix::rusage"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(144) %1, i8* nonnull align 8 dereferenceable(144) %2, i64 144, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN60_$LT$libc..unix..ipv6_mreq$u20$as$u20$core..clone..Clone$GT$5clone17h3f43912004402d0aE"(%"unix::ipv6_mreq"* noalias nocapture sret dereferenceable(20) %0, %"unix::ipv6_mreq"* mpk_immut noalias nocapture readonly align 4 dereferenceable(20) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::ipv6_mreq"* %0 to i8*
  %2 = bitcast %"unix::ipv6_mreq"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(20) %1, i8* nonnull align 4 dereferenceable(20) %2, i64 20, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define { i8*, i64 } @"_ZN56_$LT$libc..unix..iovec$u20$as$u20$core..clone..Clone$GT$5clone17hd82ebe32063b9832E"({ i8*, i64 }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %self, i64 0, i32 0
  %1 = load i8*, i8** %0, align 8
  %2 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %self, i64 0, i32 1
  %3 = load i64, i64* %2, align 8
  %4 = insertvalue { i8*, i64 } undef, i8* %1, 0
  %5 = insertvalue { i8*, i64 } %4, i64 %3, 1
  ret { i8*, i64 } %5
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN57_$LT$libc..unix..pollfd$u20$as$u20$core..clone..Clone$GT$5clone17h4c92e15de06ca525E"(%"unix::pollfd"* mpk_immut noalias nocapture readonly align 4 dereferenceable(8) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::pollfd"* %self to i64*
  %.sroa.0.0.copyload = load i64, i64* %.sroa.0.0..sroa_cast, align 4
  ret i64 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN58_$LT$libc..unix..winsize$u20$as$u20$core..clone..Clone$GT$5clone17h7c80d5408b1bcb83E"(%"unix::winsize"* mpk_immut noalias nocapture readonly align 2 dereferenceable(8) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::winsize"* %self to i64*
  %.sroa.0.0.copyload = load i64, i64* %.sroa.0.0..sroa_cast, align 2
  ret i64 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define { i32, i32 } @"_ZN57_$LT$libc..unix..linger$u20$as$u20$core..clone..Clone$GT$5clone17h722cee221fb79f74E"({ i32, i32 }* mpk_immut noalias nocapture readonly align 4 dereferenceable(8) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %self, i64 0, i32 0
  %1 = load i32, i32* %0, align 4
  %2 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %self, i64 0, i32 1
  %3 = load i32, i32* %2, align 4
  %4 = insertvalue { i32, i32 } undef, i32 %1, 0
  %5 = insertvalue { i32, i32 } %4, i32 %3, 1
  ret { i32, i32 } %5
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN57_$LT$libc..unix..sigval$u20$as$u20$core..clone..Clone$GT$5clone17h84b3328fbc81de90E"(%"unix::sigval"* mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_idx = getelementptr inbounds %"unix::sigval", %"unix::sigval"* %self, i64 0, i32 0, i64 0
  %.sroa.0.0.copyload = load i64, i64* %.sroa.0.0..sroa_idx, align 8
  ret i64 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN54_$LT$libc..unix..tms$u20$as$u20$core..clone..Clone$GT$5clone17ha2f1c36c8621a473E"(%"unix::tms"* noalias nocapture sret dereferenceable(32) %0, %"unix::tms"* mpk_immut noalias nocapture readonly align 8 dereferenceable(32) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::tms"* %0 to i8*
  %2 = bitcast %"unix::tms"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %1, i8* nonnull align 8 dereferenceable(32) %2, i64 32, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN59_$LT$libc..unix..protoent$u20$as$u20$core..clone..Clone$GT$5clone17h0ef8c5fbc4910a93E"(%"unix::protoent"* noalias nocapture sret dereferenceable(24) %0, %"unix::protoent"* mpk_immut noalias nocapture readonly align 8 dereferenceable(24) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::protoent"* %0 to i8*
  %2 = bitcast %"unix::protoent"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %1, i8* nonnull align 8 dereferenceable(24) %2, i64 24, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i32 @"_ZN70_$LT$libc..unix..linux_like..in_addr$u20$as$u20$core..clone..Clone$GT$5clone17hcc6b6fd29e52fb45E"(%"unix::linux_like::in_addr"* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_idx = getelementptr inbounds %"unix::linux_like::in_addr", %"unix::linux_like::in_addr"* %self, i64 0, i32 0, i64 0
  %.sroa.0.0.copyload = load i32, i32* %.sroa.0.0..sroa_idx, align 4
  ret i32 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN75_$LT$libc..unix..linux_like..sockaddr_in6$u20$as$u20$core..clone..Clone$GT$5clone17hb27d2f1e175f63d7E"(%"unix::linux_like::sockaddr_in6"* noalias nocapture sret dereferenceable(28) %0, %"unix::linux_like::sockaddr_in6"* mpk_immut noalias nocapture readonly align 4 dereferenceable(28) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::sockaddr_in6"* %0 to i8*
  %2 = bitcast %"unix::linux_like::sockaddr_in6"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(28) %1, i8* nonnull align 4 dereferenceable(28) %2, i64 28, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN71_$LT$libc..unix..linux_like..addrinfo$u20$as$u20$core..clone..Clone$GT$5clone17h0685a4853c93ab20E"(%"unix::linux_like::addrinfo"* noalias nocapture sret dereferenceable(48) %0, %"unix::linux_like::addrinfo"* mpk_immut noalias nocapture readonly align 8 dereferenceable(48) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::addrinfo"* %0 to i8*
  %2 = bitcast %"unix::linux_like::addrinfo"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(48) %1, i8* nonnull align 8 dereferenceable(48) %2, i64 48, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN69_$LT$libc..unix..linux_like..fd_set$u20$as$u20$core..clone..Clone$GT$5clone17h6589b1322586f879E"(%"unix::linux_like::fd_set"* noalias nocapture sret dereferenceable(128) %0, %"unix::linux_like::fd_set"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::fd_set"* %0 to i8*
  %2 = bitcast %"unix::linux_like::fd_set"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(128) %1, i8* nonnull align 8 dereferenceable(128) %2, i64 128, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN68_$LT$libc..unix..linux_like..lconv$u20$as$u20$core..clone..Clone$GT$5clone17h2a32f2191c3651deE"(%"unix::linux_like::lconv"* noalias nocapture sret dereferenceable(96) %0, %"unix::linux_like::lconv"* mpk_immut noalias nocapture readonly align 8 dereferenceable(96) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::lconv"* %0 to i8*
  %2 = bitcast %"unix::linux_like::lconv"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(96) %1, i8* nonnull align 8 dereferenceable(96) %2, i64 96, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i96 @"_ZN73_$LT$libc..unix..linux_like..in_pktinfo$u20$as$u20$core..clone..Clone$GT$5clone17habed2eed1c35b2a0E"(%"unix::linux_like::in_pktinfo"* mpk_immut noalias nocapture readonly align 4 dereferenceable(12) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::in_pktinfo"* %self to i96*
  %.sroa.0.0.copyload = load i96, i96* %.sroa.0.0..sroa_cast, align 4
  ret i96 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN72_$LT$libc..unix..linux_like..in6_rtmsg$u20$as$u20$core..clone..Clone$GT$5clone17h997b051f352c15e8E"(%"unix::linux_like::in6_rtmsg"* noalias nocapture sret dereferenceable(80) %0, %"unix::linux_like::in6_rtmsg"* mpk_immut noalias nocapture readonly align 8 dereferenceable(80) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::in6_rtmsg"* %0 to i8*
  %2 = bitcast %"unix::linux_like::in6_rtmsg"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(80) %1, i8* nonnull align 8 dereferenceable(80) %2, i64 80, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN69_$LT$libc..unix..linux_like..arpreq$u20$as$u20$core..clone..Clone$GT$5clone17hef937d49f00d3b2cE"(%"unix::linux_like::arpreq"* noalias nocapture sret dereferenceable(68) %0, %"unix::linux_like::arpreq"* mpk_immut noalias nocapture readonly align 4 dereferenceable(68) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::arpreq"* %0 to i8*
  %2 = bitcast %"unix::linux_like::arpreq"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(68) %1, i8* nonnull align 4 dereferenceable(68) %2, i64 68, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN73_$LT$libc..unix..linux_like..arpreq_old$u20$as$u20$core..clone..Clone$GT$5clone17h44b95bcc87a1ea0fE"(%"unix::linux_like::arpreq_old"* noalias nocapture sret dereferenceable(52) %0, %"unix::linux_like::arpreq_old"* mpk_immut noalias nocapture readonly align 4 dereferenceable(52) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::arpreq_old"* %0 to i8*
  %2 = bitcast %"unix::linux_like::arpreq_old"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(52) %1, i8* nonnull align 4 dereferenceable(52) %2, i64 52, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN70_$LT$libc..unix..linux_like..mmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h1c07c8d496731bfcE"(%"unix::linux_like::mmsghdr"* noalias nocapture sret dereferenceable(64) %0, %"unix::linux_like::mmsghdr"* mpk_immut noalias nocapture readonly align 8 dereferenceable(64) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::mmsghdr"* %0 to i8*
  %2 = bitcast %"unix::linux_like::mmsghdr"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(64) %1, i8* nonnull align 8 dereferenceable(64) %2, i64 64, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i96 @"_ZN74_$LT$libc..unix..linux_like..epoll_event$u20$as$u20$core..clone..Clone$GT$5clone17ha456f240f04bde6eE"(%"unix::linux_like::epoll_event"* mpk_immut noalias nocapture readonly align 1 dereferenceable(12) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::epoll_event"* %self to i96*
  %.sroa.0.0.copyload = load i96, i96* %.sroa.0.0..sroa_cast, align 1
  ret i96 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN74_$LT$libc..unix..linux_like..sockaddr_un$u20$as$u20$core..clone..Clone$GT$5clone17h70961a4e85833d13E"(%"unix::linux_like::sockaddr_un"* noalias nocapture sret dereferenceable(110) %0, %"unix::linux_like::sockaddr_un"* mpk_immut noalias nocapture readonly align 2 dereferenceable(110) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::sockaddr_un"* %0 to i8*
  %2 = bitcast %"unix::linux_like::sockaddr_un"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 2 dereferenceable(110) %1, i8* nonnull align 2 dereferenceable(110) %2, i64 110, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN70_$LT$libc..unix..linux_like..utsname$u20$as$u20$core..clone..Clone$GT$5clone17h459acfa38e5cb1f3E"(%"unix::linux_like::utsname"* noalias nocapture sret dereferenceable(390) %0, %"unix::linux_like::utsname"* mpk_immut noalias nocapture readonly align 1 dereferenceable(390) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::utsname", %"unix::linux_like::utsname"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::utsname", %"unix::linux_like::utsname"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(390) %1, i8* nonnull align 1 dereferenceable(390) %2, i64 390, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN74_$LT$libc..unix..linux_like..linux..spwd$u20$as$u20$core..clone..Clone$GT$5clone17hb18d8245fe22545bE"(%"unix::linux_like::linux::spwd"* noalias nocapture sret dereferenceable(72) %0, %"unix::linux_like::linux::spwd"* mpk_immut noalias nocapture readonly align 8 dereferenceable(72) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::spwd"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::spwd"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(72) %1, i8* nonnull align 8 dereferenceable(72) %2, i64 72, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define { i32, i8* } @"_ZN82_$LT$libc..unix..linux_like..linux..if_nameindex$u20$as$u20$core..clone..Clone$GT$5clone17h3c2ab56a04ce1147E"({ i32, i8* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %self, i64 0, i32 0
  %1 = load i32, i32* %0, align 8
  %2 = getelementptr inbounds { i32, i8* }, { i32, i8* }* %self, i64 0, i32 1
  %3 = load i8*, i8** %2, align 8
  %4 = insertvalue { i32, i8* } undef, i32 %1, 0
  %5 = insertvalue { i32, i8* } %4, i8* %3, 1
  ret { i32, i8* } %5
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN77_$LT$libc..unix..linux_like..linux..msginfo$u20$as$u20$core..clone..Clone$GT$5clone17he0213bb3c85451f0E"(%"unix::linux_like::linux::msginfo"* noalias nocapture sret dereferenceable(32) %0, %"unix::linux_like::linux::msginfo"* mpk_immut noalias nocapture readonly align 4 dereferenceable(32) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::msginfo"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::msginfo"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(32) %1, i8* nonnull align 4 dereferenceable(32) %2, i64 32, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i48 @"_ZN76_$LT$libc..unix..linux_like..linux..sembuf$u20$as$u20$core..clone..Clone$GT$5clone17h2bbbd65fc3379205E"(%"unix::linux_like::linux::sembuf"* mpk_immut noalias nocapture readonly align 2 dereferenceable(6) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::sembuf"* %self to i48*
  %.sroa.0.0.copyload = load i48, i48* %.sroa.0.0..sroa_cast, align 2
  ret i48 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN83_$LT$libc..unix..linux_like..linux..input_absinfo$u20$as$u20$core..clone..Clone$GT$5clone17hba9dfac0d14dd3ccE"(%"unix::linux_like::linux::input_absinfo"* noalias nocapture sret dereferenceable(24) %0, %"unix::linux_like::linux::input_absinfo"* mpk_immut noalias nocapture readonly align 4 dereferenceable(24) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::input_absinfo"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::input_absinfo"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(24) %1, i8* nonnull align 4 dereferenceable(24) %2, i64 24, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN88_$LT$libc..unix..linux_like..linux..input_keymap_entry$u20$as$u20$core..clone..Clone$GT$5clone17h6220ce7fa36a1507E"(%"unix::linux_like::linux::input_keymap_entry"* noalias nocapture sret dereferenceable(40) %0, %"unix::linux_like::linux::input_keymap_entry"* mpk_immut noalias nocapture readonly align 4 dereferenceable(40) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::input_keymap_entry", %"unix::linux_like::linux::input_keymap_entry"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::input_keymap_entry", %"unix::linux_like::linux::input_keymap_entry"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(40) %1, i8* nonnull align 4 dereferenceable(40) %2, i64 40, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i80 @"_ZN88_$LT$libc..unix..linux_like..linux..ff_constant_effect$u20$as$u20$core..clone..Clone$GT$5clone17hbf1ac89e140886ffE"(%"unix::linux_like::linux::ff_constant_effect"* mpk_immut noalias nocapture readonly align 2 dereferenceable(10) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::ff_constant_effect"* %self to i80*
  %.sroa.0.0.copyload = load i80, i80* %.sroa.0.0..sroa_cast, align 2
  ret i80 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i96 @"_ZN84_$LT$libc..unix..linux_like..linux..ff_ramp_effect$u20$as$u20$core..clone..Clone$GT$5clone17h327902ed483ee6efE"(%"unix::linux_like::linux::ff_ramp_effect"* mpk_immut noalias nocapture readonly align 2 dereferenceable(12) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::ff_ramp_effect"* %self to i96*
  %.sroa.0.0.copyload = load i96, i96* %.sroa.0.0..sroa_cast, align 2
  ret i96 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN86_$LT$libc..unix..linux_like..linux..uinput_ff_upload$u20$as$u20$core..clone..Clone$GT$5clone17hf5f4429594e84b2fE"(%"unix::linux_like::linux::uinput_ff_upload"* noalias nocapture sret dereferenceable(104) %0, %"unix::linux_like::linux::uinput_ff_upload"* mpk_immut noalias nocapture readonly align 8 dereferenceable(104) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::uinput_ff_upload"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::uinput_ff_upload"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(104) %1, i8* nonnull align 8 dereferenceable(104) %2, i64 104, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..Elf32_Ehdr$u20$as$u20$core..clone..Clone$GT$5clone17he2e236e4d18a5010E"(%"unix::linux_like::linux::Elf32_Ehdr"* noalias nocapture sret dereferenceable(52) %0, %"unix::linux_like::linux::Elf32_Ehdr"* mpk_immut noalias nocapture readonly align 4 dereferenceable(52) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::Elf32_Ehdr", %"unix::linux_like::linux::Elf32_Ehdr"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::Elf32_Ehdr", %"unix::linux_like::linux::Elf32_Ehdr"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(52) %1, i8* nonnull align 4 dereferenceable(52) %2, i64 52, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..Elf64_Ehdr$u20$as$u20$core..clone..Clone$GT$5clone17h126bc0298e3a4755E"(%"unix::linux_like::linux::Elf64_Ehdr"* noalias nocapture sret dereferenceable(64) %0, %"unix::linux_like::linux::Elf64_Ehdr"* mpk_immut noalias nocapture readonly align 8 dereferenceable(64) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::Elf64_Ehdr", %"unix::linux_like::linux::Elf64_Ehdr"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::Elf64_Ehdr", %"unix::linux_like::linux::Elf64_Ehdr"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(64) %1, i8* nonnull align 8 dereferenceable(64) %2, i64 64, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..Elf32_Shdr$u20$as$u20$core..clone..Clone$GT$5clone17h96cb0be33d1d2b2bE"(%"unix::linux_like::linux::Elf32_Shdr"* noalias nocapture sret dereferenceable(40) %0, %"unix::linux_like::linux::Elf32_Shdr"* mpk_immut noalias nocapture readonly align 4 dereferenceable(40) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::Elf32_Shdr"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::Elf32_Shdr"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(40) %1, i8* nonnull align 4 dereferenceable(40) %2, i64 40, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN76_$LT$libc..unix..linux_like..linux..mntent$u20$as$u20$core..clone..Clone$GT$5clone17h9fde77384649b643E"(%"unix::linux_like::linux::mntent"* noalias nocapture sret dereferenceable(40) %0, %"unix::linux_like::linux::mntent"* mpk_immut noalias nocapture readonly align 8 dereferenceable(40) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::mntent"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::mntent"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %1, i8* nonnull align 8 dereferenceable(40) %2, i64 40, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN87_$LT$libc..unix..linux_like..linux..posix_spawnattr_t$u20$as$u20$core..clone..Clone$GT$5clone17hece67e28d6918cb1E"(%"unix::linux_like::linux::posix_spawnattr_t"* noalias nocapture sret dereferenceable(336) %0, %"unix::linux_like::linux::posix_spawnattr_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(336) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::posix_spawnattr_t"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::posix_spawnattr_t"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(336) %1, i8* nonnull align 8 dereferenceable(336) %2, i64 336, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i32 @"_ZN80_$LT$libc..unix..linux_like..linux..genlmsghdr$u20$as$u20$core..clone..Clone$GT$5clone17h0e0c9b01b3e35359E"(%"unix::linux_like::linux::genlmsghdr"* mpk_immut noalias nocapture readonly align 2 dereferenceable(4) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::genlmsghdr"* %self to i32*
  %.sroa.0.0.copyload = load i32, i32* %.sroa.0.0..sroa_cast, align 2
  ret i32 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i128 @"_ZN102_$LT$libc..unix..linux_like..linux..__c_anonymous_sockaddr_can_j1939$u20$as$u20$core..clone..Clone$GT$5clone17h0929051400ce0ceaE"(%"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::__c_anonymous_sockaddr_can_j1939"* %self to i128*
  %.sroa.0.0.copyload = load i128, i128* %.sroa.0.0..sroa_cast, align 8
  ret i128 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define { i16, i32* } @"_ZN80_$LT$libc..unix..linux_like..linux..sock_fprog$u20$as$u20$core..clone..Clone$GT$5clone17h2fd3da1ba4545b92E"({ i16, i32* }* mpk_immut noalias nocapture readonly align 8 dereferenceable(16) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds { i16, i32* }, { i16, i32* }* %self, i64 0, i32 0
  %1 = load i16, i16* %0, align 8
  %2 = getelementptr inbounds { i16, i32* }, { i16, i32* }* %self, i64 0, i32 1
  %3 = load i32*, i32** %2, align 8
  %4 = insertvalue { i16, i32* } undef, i16 %1, 0
  %5 = insertvalue { i16, i32* } %4, i32* %3, 1
  ret { i16, i32* } %5
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define { i16, i16 } @"_ZN76_$LT$libc..unix..linux_like..linux..nlattr$u20$as$u20$core..clone..Clone$GT$5clone17hdf7506b097368518E"({ i16, i16 }* mpk_immut noalias nocapture readonly align 2 dereferenceable(4) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i64 0, i32 0
  %1 = load i16, i16* %0, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i64 0, i32 1
  %3 = load i16, i16* %2, align 2
  %4 = insertvalue { i16, i16 } undef, i16 %1, 0
  %5 = insertvalue { i16, i16 } %4, i16 %3, 1
  ret { i16, i16 } %5
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN76_$LT$libc..unix..linux_like..linux..dirent$u20$as$u20$core..clone..Clone$GT$5clone17h79615945466cf71dE"(%"unix::linux_like::linux::dirent"* noalias nocapture sret dereferenceable(280) %0, %"unix::linux_like::linux::dirent"* mpk_immut noalias nocapture readonly align 8 dereferenceable(280) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::dirent"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::dirent"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(280) %1, i8* nonnull align 8 dereferenceable(280) %2, i64 280, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN82_$LT$libc..unix..linux_like..linux..sockaddr_alg$u20$as$u20$core..clone..Clone$GT$5clone17h533df03baa235568E"(%"unix::linux_like::linux::sockaddr_alg"* noalias nocapture sret dereferenceable(88) %0, %"unix::linux_like::linux::sockaddr_alg"* mpk_immut noalias nocapture readonly align 4 dereferenceable(88) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::sockaddr_alg"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::sockaddr_alg"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(88) %1, i8* nonnull align 4 dereferenceable(88) %2, i64 88, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN82_$LT$libc..unix..linux_like..linux..uinput_setup$u20$as$u20$core..clone..Clone$GT$5clone17h922e383bb86886faE"(%"unix::linux_like::linux::uinput_setup"* noalias nocapture sret dereferenceable(92) %0, %"unix::linux_like::linux::uinput_setup"* mpk_immut noalias nocapture readonly align 4 dereferenceable(92) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::uinput_setup"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::uinput_setup"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(92) %1, i8* nonnull align 4 dereferenceable(92) %2, i64 92, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN85_$LT$libc..unix..linux_like..linux..uinput_user_dev$u20$as$u20$core..clone..Clone$GT$5clone17h9bebac60522677e7E"(%"unix::linux_like::linux::uinput_user_dev"* noalias nocapture sret dereferenceable(1116) %0, %"unix::linux_like::linux::uinput_user_dev"* mpk_immut noalias nocapture readonly align 4 dereferenceable(1116) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::uinput_user_dev", %"unix::linux_like::linux::uinput_user_dev"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::uinput_user_dev", %"unix::linux_like::linux::uinput_user_dev"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(1116) %1, i8* nonnull align 4 dereferenceable(1116) %2, i64 1116, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define mpk_unsafe i8* @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$7si_addr17h1ac78fd351be8081E"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 1
  %1 = bitcast i32* %0 to i8**
  %2 = load i8*, i8** %1, align 8
  ret i8* %2
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$8si_value17h27f2708e1de8f6faE"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_idx = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 3
  %0 = bitcast i32* %.sroa.0.0..sroa_idx to i64*
  %.sroa.0.0.copyload = load i64, i64* %0, align 8
  ret i64 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..gnu..statx$u20$as$u20$core..clone..Clone$GT$5clone17h9b305f1591ba7d3cE"(%"unix::linux_like::linux::gnu::statx"* noalias nocapture sret dereferenceable(256) %0, %"unix::linux_like::linux::gnu::statx"* mpk_immut noalias nocapture readonly align 8 dereferenceable(256) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::statx"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::statx"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(256) %1, i8* nonnull align 8 dereferenceable(256) %2, i64 256, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..gnu..aiocb$u20$as$u20$core..clone..Clone$GT$5clone17h29c382b65b57fd35E"(%"unix::linux_like::linux::gnu::aiocb"* noalias nocapture sret dereferenceable(168) %0, %"unix::linux_like::linux::gnu::aiocb"* mpk_immut noalias nocapture readonly align 8 dereferenceable(168) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::aiocb"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::aiocb"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(168) %1, i8* nonnull align 8 dereferenceable(168) %2, i64 168, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN82_$LT$libc..unix..linux_like..linux..gnu..termios$u20$as$u20$core..clone..Clone$GT$5clone17hd180c33d6128fb87E"(%"unix::linux_like::linux::gnu::termios"* noalias nocapture sret dereferenceable(60) %0, %"unix::linux_like::linux::gnu::termios"* mpk_immut noalias nocapture readonly align 4 dereferenceable(60) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::termios"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::termios"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(60) %1, i8* nonnull align 4 dereferenceable(60) %2, i64 60, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN82_$LT$libc..unix..linux_like..linux..gnu..rtentry$u20$as$u20$core..clone..Clone$GT$5clone17hd08bb9c8a0fa1ebfE"(%"unix::linux_like::linux::gnu::rtentry"* noalias nocapture sret dereferenceable(120) %0, %"unix::linux_like::linux::gnu::rtentry"* mpk_immut noalias nocapture readonly align 8 dereferenceable(120) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::rtentry"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::rtentry"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(120) %1, i8* nonnull align 8 dereferenceable(120) %2, i64 120, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..gnu..timex$u20$as$u20$core..clone..Clone$GT$5clone17h1d0c75e6dc2f1a6fE"(%"unix::linux_like::linux::gnu::timex"* noalias nocapture sret dereferenceable(208) %0, %"unix::linux_like::linux::gnu::timex"* mpk_immut noalias nocapture readonly align 8 dereferenceable(208) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::timex"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::timex"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(208) %1, i8* nonnull align 8 dereferenceable(208) %2, i64 208, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i32 @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$6si_pid17hd37285a3ce05d0dbE"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 1
  %1 = load i32, i32* %0, align 8
  ret i32 %1
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i32 @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$6si_uid17ha24d935a5898dcabE"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 2
  %1 = load i32, i32* %0, align 4
  ret i32 %1
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i32 @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$9si_status17h17053e7db5006a99E"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 3
  %1 = load i32, i32* %0, align 8
  ret i32 %1
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$8si_utime17h23e2962bee2b9389E"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 5
  %1 = bitcast i32* %0 to i64*
  %2 = load i64, i64* %1, align 8
  ret i64 %2
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN4libc4unix10linux_like5linux3gnu76_$LT$impl$u20$libc..unix..linux_like..linux..gnu..b64..x86_64..siginfo_t$GT$8si_stime17ha9ed9e7cb2d51e02E"(%"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(128) %self) unnamed_addr #2 {
start:
  %0 = getelementptr inbounds %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t", %"unix::linux_like::linux::gnu::b64::x86_64::siginfo_t"* %self, i64 0, i32 7, i64 7
  %1 = bitcast i32* %0 to i64*
  %2 = load i64, i64* %1, align 8
  ret i64 %2
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN80_$LT$libc..unix..linux_like..linux..gnu..utmpx$u20$as$u20$core..clone..Clone$GT$5clone17hcc75e8502c26ef95E"(%"unix::linux_like::linux::gnu::utmpx"* noalias nocapture sret dereferenceable(384) %0, %"unix::linux_like::linux::gnu::utmpx"* mpk_immut noalias nocapture readonly align 4 dereferenceable(384) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::utmpx"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::utmpx"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(384) %1, i8* nonnull align 4 dereferenceable(384) %2, i64 384, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN97_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..sigaction$u20$as$u20$core..clone..Clone$GT$5clone17hef50090e451d7ed9E"(%"unix::linux_like::linux::gnu::b64::x86_64::sigaction"* noalias nocapture sret dereferenceable(152) %0, %"unix::linux_like::linux::gnu::b64::x86_64::sigaction"* mpk_immut noalias nocapture readonly align 8 dereferenceable(152) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::sigaction"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::sigaction"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(152) %1, i8* nonnull align 8 dereferenceable(152) %2, i64 152, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN102_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..pthread_attr_t$u20$as$u20$core..clone..Clone$GT$5clone17h22da86904259d03fE"(%"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"* noalias nocapture sret dereferenceable(56) %0, %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(56) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::pthread_attr_t"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(56) %1, i8* nonnull align 8 dereferenceable(56) %2, i64 56, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i128 @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_fpxreg$u20$as$u20$core..clone..Clone$GT$5clone17ha2879f88ccf1e663E"(%"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpxreg"* mpk_immut noalias nocapture readonly align 2 dereferenceable(16) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpxreg"* %self to i128*
  %.sroa.0.0.copyload = load i128, i128* %.sroa.0.0..sroa_cast, align 2
  ret i128 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i128 @"_ZN100_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_xmmreg$u20$as$u20$core..clone..Clone$GT$5clone17ha0455ab27d8452a6E"(%"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"* mpk_immut noalias nocapture readonly align 4 dereferenceable(16) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::_libc_xmmreg"* %self to i128*
  %.sroa.0.0.copyload = load i128, i128* %.sroa.0.0..sroa_cast, align 4
  ret i128 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN101_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64.._libc_fpstate$u20$as$u20$core..clone..Clone$GT$5clone17h7a8d74b8426e4d5aE"(%"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"* noalias nocapture sret dereferenceable(512) %0, %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"* mpk_immut noalias nocapture readonly align 8 dereferenceable(512) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::_libc_fpstate"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(512) %1, i8* nonnull align 8 dereferenceable(512) %2, i64 512, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN104_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..user_regs_struct$u20$as$u20$core..clone..Clone$GT$5clone17hacde7f29492153e4E"(%"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct"* noalias nocapture sret dereferenceable(216) %0, %"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct"* mpk_immut noalias nocapture readonly align 8 dereferenceable(216) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::user_regs_struct"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(216) %1, i8* nonnull align 8 dereferenceable(216) %2, i64 216, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN92_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..user$u20$as$u20$core..clone..Clone$GT$5clone17h209fcb09de498a7bE"(%"unix::linux_like::linux::gnu::b64::x86_64::user"* noalias nocapture sret dereferenceable(912) %0, %"unix::linux_like::linux::gnu::b64::x86_64::user"* mpk_immut noalias nocapture readonly align 8 dereferenceable(912) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::user"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::user"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(912) %1, i8* nonnull align 8 dereferenceable(912) %2, i64 912, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN96_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..termios2$u20$as$u20$core..clone..Clone$GT$5clone17h56129b74dd130e85E"(%"unix::linux_like::linux::gnu::b64::x86_64::termios2"* noalias nocapture sret dereferenceable(44) %0, %"unix::linux_like::linux::gnu::b64::x86_64::termios2"* mpk_immut noalias nocapture readonly align 4 dereferenceable(44) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::termios2"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::termios2"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(44) %1, i8* nonnull align 4 dereferenceable(44) %2, i64 44, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN98_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..ucontext_t$u20$as$u20$core..clone..Clone$GT$5clone17hdd8957f0e7002ff3E"(%"unix::linux_like::linux::gnu::b64::x86_64::ucontext_t"* noalias nocapture sret dereferenceable(936) %0, %"unix::linux_like::linux::gnu::b64::x86_64::ucontext_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(936) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::ucontext_t"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::ucontext_t"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(936) %1, i8* nonnull align 8 dereferenceable(936) %2, i64 936, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN104_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..not_x32..statvfs$u20$as$u20$core..clone..Clone$GT$5clone17hf9db3cfcc68b9c03E"(%"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"* noalias nocapture sret dereferenceable(112) %0, %"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"* mpk_immut noalias nocapture readonly align 8 dereferenceable(112) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::not_x32::statvfs"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(112) %1, i8* nonnull align 8 dereferenceable(112) %2, i64 112, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN106_$LT$libc..unix..linux_like..linux..gnu..b64..x86_64..align..max_align_t$u20$as$u20$core..clone..Clone$GT$5clone17h2439941eeea9e53fE"(%"unix::linux_like::linux::gnu::b64::x86_64::align::max_align_t"* noalias nocapture sret dereferenceable(32) %0, %"unix::linux_like::linux::gnu::b64::x86_64::align::max_align_t"* mpk_immut noalias nocapture readonly align 16 dereferenceable(32) %self) unnamed_addr #1 {
start:
  %1 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::align::max_align_t"* %0 to i8*
  %2 = bitcast %"unix::linux_like::linux::gnu::b64::x86_64::align::max_align_t"* %self to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(32) %1, i8* nonnull align 16 dereferenceable(32) %2, i64 32, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN87_$LT$libc..unix..linux_like..linux..gnu..align..sem_t$u20$as$u20$core..clone..Clone$GT$5clone17h7a688c9e67b62eefE"(%"unix::linux_like::linux::gnu::align::sem_t"* noalias nocapture sret dereferenceable(32) %0, %"unix::linux_like::linux::gnu::align::sem_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(32) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::gnu::align::sem_t", %"unix::linux_like::linux::gnu::align::sem_t"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::gnu::align::sem_t", %"unix::linux_like::linux::gnu::align::sem_t"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %1, i8* nonnull align 8 dereferenceable(32) %2, i64 32, i1 false)
  ret void
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i64 @"_ZN90_$LT$libc..unix..linux_like..linux..pthread_rwlockattr_t$u20$as$u20$core..clone..Clone$GT$5clone17h0979da4cddd78353E"(%"unix::linux_like::linux::pthread_rwlockattr_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(8) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::pthread_rwlockattr_t"* %self to i64*
  %.sroa.0.0.copyload = load i64, i64* %.sroa.0.0..sroa_cast, align 8
  ret i64 %.sroa.0.0.copyload
}

; Function Attrs: norecurse nounwind nonlazybind readonly uwtable
define i32 @"_ZN88_$LT$libc..unix..linux_like..linux..pthread_condattr_t$u20$as$u20$core..clone..Clone$GT$5clone17h0a100297856cd22aE"(%"unix::linux_like::linux::pthread_condattr_t"* mpk_immut noalias nocapture readonly align 4 dereferenceable(4) %self) unnamed_addr #2 {
start:
  %.sroa.0.0..sroa_cast = bitcast %"unix::linux_like::linux::pthread_condattr_t"* %self to i32*
  %.sroa.0.0.copyload = load i32, i32* %.sroa.0.0..sroa_cast, align 4
  ret i32 %.sroa.0.0.copyload
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN84_$LT$libc..unix..linux_like..linux..pthread_cond_t$u20$as$u20$core..clone..Clone$GT$5clone17h0c450fe1d7d66d70E"(%"unix::linux_like::linux::pthread_cond_t"* noalias nocapture sret dereferenceable(48) %0, %"unix::linux_like::linux::pthread_cond_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(48) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::pthread_cond_t", %"unix::linux_like::linux::pthread_cond_t"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::pthread_cond_t", %"unix::linux_like::linux::pthread_cond_t"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(48) %1, i8* nonnull align 8 dereferenceable(48) %2, i64 48, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN85_$LT$libc..unix..linux_like..linux..pthread_mutex_t$u20$as$u20$core..clone..Clone$GT$5clone17h2daad908639aa16aE"(%"unix::linux_like::linux::pthread_mutex_t"* noalias nocapture sret dereferenceable(40) %0, %"unix::linux_like::linux::pthread_mutex_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(40) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::pthread_mutex_t", %"unix::linux_like::linux::pthread_mutex_t"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::pthread_mutex_t", %"unix::linux_like::linux::pthread_mutex_t"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(40) %1, i8* nonnull align 8 dereferenceable(40) %2, i64 40, i1 false)
  ret void
}

; Function Attrs: nounwind nonlazybind uwtable
define void @"_ZN86_$LT$libc..unix..linux_like..linux..pthread_rwlock_t$u20$as$u20$core..clone..Clone$GT$5clone17hc43f3a3a1e35cbbeE"(%"unix::linux_like::linux::pthread_rwlock_t"* noalias nocapture sret dereferenceable(56) %0, %"unix::linux_like::linux::pthread_rwlock_t"* mpk_immut noalias nocapture readonly align 8 dereferenceable(56) %self) unnamed_addr #1 {
start:
  %1 = getelementptr inbounds %"unix::linux_like::linux::pthread_rwlock_t", %"unix::linux_like::linux::pthread_rwlock_t"* %0, i64 0, i32 0, i64 0
  %2 = getelementptr inbounds %"unix::linux_like::linux::pthread_rwlock_t", %"unix::linux_like::linux::pthread_rwlock_t"* %self, i64 0, i32 0, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(56) %1, i8* nonnull align 8 dereferenceable(56) %2, i64 56, i1 false)
  ret void
}

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

attributes #0 = { noreturn nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #1 = { nounwind nonlazybind uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #2 = { norecurse nounwind nonlazybind readonly uwtable "probe-stack"="__rust_probestack" "target-cpu"="x86-64" }
attributes #3 = { cold noreturn nounwind }
attributes #4 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
