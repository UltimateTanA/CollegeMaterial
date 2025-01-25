#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <stdint.h>

#define PORT 8080
#define BUFLEN 512

// Function to calculate 32-bit checksum
uint32_t calculate_checksum(const char *buffer, size_t length) {
    uint32_t checksum = 0;
    for (size_t i = 0; i < length; i++) {
        checksum += buffer[i];
    }
    return ~checksum;
}

int main() {
    struct sockaddr_in server_addr, client_addr;
    int sockfd, recv_len;
    socklen_t client_len = sizeof(client_addr);
    char buffer[BUFLEN];
    
    // Create a UDP socket
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    // Setup server address structure
    memset((char *)&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);

    // Bind socket to the server address
    if (bind(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1) {
        perror("Bind failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("Server is waiting for data...\n");

    while (1) {
        // Clear buffer
        memset(buffer, 0, BUFLEN);

        // Receive data from client
        recv_len = recvfrom(sockfd, buffer, BUFLEN, 0, (struct sockaddr *)&client_addr, &client_len);
        if (recv_len == -1) {
            perror("Failed to receive data");
            exit(EXIT_FAILURE);
        }

        // Extract checksum from received data
        uint32_t received_checksum = *(uint32_t *)buffer;
        // Calculate checksum on received data (excluding the checksum field)
        uint32_t calculated_checksum = calculate_checksum(buffer + sizeof(uint32_t), recv_len - sizeof(uint32_t));

        // Verify the checksum
        if (received_checksum == calculated_checksum) {
            printf("Checksum matches! Message received: %s\n", buffer + sizeof(uint32_t));
        } else {
            char error_msg[] = "Error: Checksum does not match!";
            printf("%s\n", error_msg);
            sendto(sockfd, error_msg, strlen(error_msg), 0, (struct sockaddr *)&client_addr, client_len);
        }
    }

    close(sockfd);
    return 0;
}
